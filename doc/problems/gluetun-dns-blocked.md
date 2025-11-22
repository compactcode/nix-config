# Gluetun DNS "Operation Not Permitted" Error

Gluetun container fails to connect with DNS resolution errors, continuously restarting.

## Symptoms

```
[healthcheck] healthcheck error: dialing: dial tcp4: lookup cloudflare.com on 1.1.1.1:53:
write udp 192.168.1.101:XXXXX->1.1.1.1:53: write: operation not permitted
```

The service enters a continuous restart loop every 6-60 seconds.

## Quick Reproduction

```bash
# Run gluetun with default healthcheck (uses hostname)
podman run --rm --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun \
  --env-file /path/to/secret.env -e SERVER_COUNTRIES=Australia \
  ghcr.io/qdm12/gluetun:v3.40.3

# Observe error after 6 seconds:
# healthcheck error: lookup cloudflare.com on 1.1.1.1:53: operation not permitted
```

## Root Cause

**The "operation not permitted" error is gluetun's firewall working as designed** - it blocks all outbound traffic (including DNS) to prevent VPN leaks before the tunnel is established.

The actual problem chain:

1. **VPN never connects** (OpenVPN shows no TLS handshake attempts)
2. **Without VPN tunnel**, gluetun's DNS server (unbound) never starts
3. **Healthcheck tries to resolve `cloudflare.com`** via fallback DNS (1.1.1.1)
4. **Gluetun's firewall blocks it** (leak prevention working correctly)
5. **Healthcheck fails** → VPN restart → infinite loop

### Why VPN doesn't connect

OpenVPN should show TLS handshake messages but remains completely silent:

```bash
# Check OpenVPN logs - should see TLS handshake, but doesn't:
podman logs gluetun | grep -i openvpn

# Expected (working VPN):
# [openvpn] Attempting connection to...
# [openvpn] TLS: Initial packet from...
# [openvpn] Initialization Sequence Completed

# Actual (broken):
# [openvpn] UDPv4 link remote: [AF_INET]45.132.225.8:1195
# [silence - no connection attempts]
```

**This is the underlying issue that needs investigation.**

## Diagnostic Commands

### Verify gluetun's firewall is blocking DNS

```bash
# Check container's iptables OUTPUT chain
podman exec gluetun iptables -L OUTPUT -n -v

# Should show:
# Chain OUTPUT (policy DROP ...)  ← Default DROP policy
# Only specific rules allowed (VPN server, tun0, local network)
```

### Check if DNS works from a basic container

```bash
# Test that host/podman DNS works in general
podman run --rm alpine:latest nslookup cloudflare.com 1.1.1.1
# Should succeed ✓ (proves issue is gluetun-specific)
```

### Verify DNS server status in gluetun

```bash
# Check if unbound DNS server is running
podman exec gluetun ps aux

# Expected when VPN is up:
# unbound process should be running

# Actual when VPN is down:
# Only gluetun-entrypoint and openvpn processes (no unbound)
```

### Check what's in /etc/resolv.conf

```bash
# See what DNS the container is configured to use
podman exec gluetun cat /etc/resolv.conf

# Shows: nameserver 1.1.1.1
# Should show: nameserver 127.0.0.1 (but gluetun overwrites it)
```

## Key Findings from Investigation

1. **Basic containers CAN query DNS**: Alpine container successfully queries 1.1.1.1 ✓
2. **Gluetun's firewall has DROP policy**: All outbound traffic blocked by default ✓
3. **DNS server doesn't start**: `unbound` process not running until VPN connects ✓
4. **OpenVPN is silent**: No TLS handshake attempts logged (actual root cause)
5. **Healthcheck uses wrong variable**: `HEALTH_TARGET_ADDRESSES` (plural) doesn't work

## Technical Details

### Gluetun's Security Design

Gluetun implements a strict firewall to prevent VPN leaks:

```bash
# Allowed outbound traffic:
1. Loopback (lo)
2. Established connections
3. Local network (192.168.1.0/24)
4. Specific VPN server IP + port (e.g., 45.132.225.8:1195)
5. VPN tunnel interface (tun0)

# Everything else: DROPPED
```

This is **intentional and correct** - prevents data leaks before VPN connects.

### The Chicken-and-Egg Problem

```
Healthcheck needs DNS
    ↓
DNS requires gluetun's internal server (unbound)
    ↓
Unbound requires VPN tunnel (tun0)
    ↓
VPN tunnel requires OpenVPN to connect
    ↓
OpenVPN not connecting (root cause!)
    ↓
Healthcheck can't wait, uses fallback DNS (1.1.1.1)
    ↓
Firewall blocks it → "operation not permitted"
```

### Why Using IP Address Works

Using `HEALTH_TARGET_ADDRESS="1.1.1.1:443"`:
- Healthcheck connects directly to IP (no DNS lookup needed)
- Doesn't require unbound to be running
- Doesn't require VPN to be up
- Doesn't trigger firewall DNS blocking
- Still validates connectivity (though will timeout until VPN connects)

## Outstanding Issues

**Primary issue**: Why doesn't OpenVPN attempt TLS handshakes?

Investigation needed:
- OpenVPN configuration validation
- Network routing to VPN servers
- Packet capture to see if UDP packets reach VPN server
- ExpressVPN credential/server validity

## References

- Gluetun firewall docs: https://github.com/qdm12/gluetun-wiki/blob/main/setup/options/firewall.md
- Gluetun health config: https://github.com/qdm12/gluetun/blob/master/internal/configuration/settings/health.go
- Similar issue discussion: https://github.com/qdm12/gluetun-wiki/blob/main/faq/healthcheck.md
