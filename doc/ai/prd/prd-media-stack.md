# PRD: Declarative Media Management Stack

## 1. Introduction/Overview

This document outlines the requirements for adding a comprehensive, automated media management stack to the `pudge` homelab server. The goal is to create a fully declarative system for discovering, downloading, and organizing movies and TV shows, aligning with the project's guiding principles of declarative, secure, and minimal infrastructure.

The stack will consist of four primary services:
*   **Radarr:** For automated movie management.
*   **Sonarr:** For automated TV show management.
*   **Prowlarr:** To manage indexer configurations for Radarr and Sonarr.
*   **Transmission:** A torrent client for downloading media.

These services will be deployed as OCI containers using NixOS's native capabilities, ensuring the entire configuration is reproducible and version-controlled. A key security requirement is that all download traffic must be routed through a VPN.

## 2. Goals

*   **Automation:** Fully automate the process of searching for, downloading, and organizing a media library.
*   **Security:** Ensure all torrent-related network traffic is forced through a secure VPN tunnel (Mullvad) to maintain privacy.
*   **Declarative Configuration:** Define the entire service stack, including networking and data volumes, declaratively within the existing NixOS configuration.
*   **Data Persistence:** Persist all service configurations and media files on the existing NFS shares.
*   **Reliability:** Implement a clear dependency chain where services only start once their dependencies (like the VPN connection) are ready.

## 3. User Stories

*   **As a homelab user, I want to add a movie to Radarr, which then uses Prowlarr to find the movie from an indexer, sends it to Transmission for download over a VPN, and finally moves the completed file to my movies directory, making it available in my media library.**
*   **As a homelab user, I want to add a TV series to Sonarr, which then automatically monitors for new episodes, uses Prowlarr to find them, sends them to Transmission for download over a VPN, and organizes the completed files into my TV shows directory.**
*   **As a system administrator, I want all torrent-related network traffic to be forced through a VPN to ensure privacy, without affecting other services on the server.**

## 4. Functional Requirements

1.  **Service Deployment:** The system must deploy four services: Radarr, Sonarr, Prowlarr, and Transmission.
2.  **Containerization:** All services must be deployed as OCI containers using the `virtualisation.oci-containers` NixOS module with the Podman backend.
3.  **Image Source:** All container images must be sourced from `linuxserver.io`.
4.  **Version Pinning:** Container image versions must be pinned to specific versions/digests to ensure reproducibility and prevent unexpected updates.
5.  **VPN Routing:** Prowlarr and Transmission network traffic must be routed exclusively through a VPN. A dedicated VPN container shall be used to provide the network for these services.
6.  **Split Tunneling:** Radarr and Sonarr network traffic must *not* be routed through the VPN and should use the host's primary network interface.
7.  **Service Dependencies:** Radarr and Sonarr must be configured to start only after Prowlarr and Transmission are running and the VPN is confirmed to be connected.
8.  **Data Storage:** All services must persist their configuration and data using NFS mounts following the established pattern.
9.  **Network Access:** The services' web UIs must be accessible directly via the server's IP address on their default ports:
    *   Radarr: `7878`
    *   Sonarr: `8989`
    *   Prowlarr: `9696`
    *   Transmission: `9091`

## 5. Non-Goals (Out of Scope)

*   This PRD does not cover the configuration of a reverse proxy for the services.
*   This PRD does not cover the initial setup of the NFS shares on the host system.
*   This PRD does not cover the internal application configuration of Radarr, Sonarr, or Prowlarr (e.g., adding indexers, setting quality profiles).
*   The user is responsible for providing a valid Mullvad VPN configuration file.

## 6. Technical Implementation Requirements

### Module Structure
Each service must be implemented as a separate module in `modules/services/` following the established conventions:

*   **File Naming:** `modules/services/radarr.nix`, `modules/services/sonarr.nix`, `modules/services/prowlarr.nix`, `modules/services/transmission.nix`
*   **Module Pattern:** Use `delib.module` with `name = "services.<servicename>"` 
*   **Options:** Use `delib.singleEnableOption false` for simple enable/disable modules
*   **Configuration Scope:** Use `nixos.ifEnabled = {myconfig, ...}:` for NixOS-specific configuration

### Container Configuration
Following the pattern established by `emby.nix` and `homeassistant.nix`:

*   **Image Specification:** Use pinned images with specific versions:
    *   Prowlarr: `"lscr.io/linuxserver/prowlarr:1.20.1.4603-ls78"`
    *   Radarr: `"lscr.io/linuxserver/radarr:5.7.0.8882-ls229"`
    *   Sonarr: `"lscr.io/linuxserver/sonarr:4.0.8.1874-ls248"`
    *   Transmission: `"lscr.io/linuxserver/transmission:4.0.6-r0-ls246"`

*   **Port Configuration:** Each service must expose its default port using the `ports` attribute
*   **Environment Variables:** Include standard LinuxServer.io environment variables:
    ```nix
    environment = {
      PUID = "1000";
      PGID = "1000";
      TZ = myconfig.locale.timeZone;
    };
    ```

### Storage and Dependencies
*   **NFS Dependencies:** Each service must include systemd dependencies for required NFS mounts:
    ```nix
    systemd.services.podman-<servicename> = {
      after = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
      requires = ["mnt-nfs-config.mount" "mnt-nfs-media.mount"];
    };
    ```

*   **Volume Mounts:** Use NFS mount paths following the pattern:
    *   Configuration: `"/mnt/nfs/config/<servicename>:/config"`
    *   Media: `"/mnt/nfs/media:/data"` (where applicable)
    *   Downloads: `"/mnt/nfs/media/downloads:/downloads"` (for download clients)

### Firewall Configuration
Each service must open its respective firewall port:
```nix
networking.firewall.allowedTCPPorts = [<port>];
```

### VPN Integration
*   **VPN Container:** Implement a separate `gluetun` container for VPN functionality
*   **Network Sharing:** Configure Transmission and Prowlarr to use the VPN container's network via `network_mode: "container:gluetun"`
*   **VPN Dependencies:** Services using the VPN must depend on the VPN container being ready

### Service Interdependencies
*   Radarr and Sonarr services must include dependencies on Prowlarr and Transmission:
    ```nix
    systemd.services.podman-radarr = {
      after = ["podman-prowlarr.service" "podman-transmission.service"];
      requires = ["podman-prowlarr.service" "podman-transmission.service"];
    };
    ```

## 7. Success Metrics

*   All four service containers are running and accessible on their specified ports.
*   The `gluetun` container successfully establishes a connection to Mullvad.
*   The Transmission and Prowlarr containers route all their traffic through the `gluetun` container.
*   Radarr and Sonarr can successfully communicate with Prowlarr and Transmission over the local container network.
*   A test download initiated by Radarr or Sonarr completes successfully, and the resulting media file is correctly moved from the downloads directory to the movies or TV directory.
*   All services automatically start in the correct order with proper dependency handling.
*   All service configurations persist across system reboots via NFS mounts.

## 8. Implementation Notes

*   Follow the established module structure exactly as demonstrated in `emby.nix` and `homeassistant.nix`
*   Use the same systemd service naming pattern: `podman-<servicename>`
*   Maintain consistency with environment variable configuration across all services
*   Ensure all modules are disabled by default and require explicit enablement
*   Reference `myconfig.locale.timeZone` for timezone configuration to maintain consistency with other services
