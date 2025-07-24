## Relevant Files

- `modules/services/homeassistant.nix` - New module for Home Assistant container service configuration
- `modules/services/emby.nix` - New module for Emby container service configuration
- `features/homelab.nix` - New feature to enable containerized homelab services
- `hosts/pudge/default.nix` - Host configuration to enable the homelab feature
- `modules/programs/podman.nix` - Existing Podman module (may need modifications for OCI containers integration)

### Notes

- Use `nh os build` to test the configuration
- Refer to `doc/standards/development.md` for project structure and conventions
- The existing Podman module provides the foundation but needs OCI containers integration
- NFS client module is already configured on pudge host for "config" and "media" shares

## Tasks

- [ ] 1.0 Configure OCI Containers Infrastructure
  - [ ] 1.1 Enable virtualisation.oci-containers in NixOS configuration
  - [ ] 1.2 Set podman as the default backend for OCI containers
  - [ ] 1.3 Ensure proper systemd integration for container lifecycle management
  - [ ] 1.4 Configure container networking and firewall rules
- [ ] 2.0 Implement Home Assistant Service Module
  - [ ] 2.1 Create modules/services/homeassistant.nix following denix module structure
  - [ ] 2.2 Configure LinuxServer.io Home Assistant container image
  - [ ] 2.3 Set up NFS volume mounts for Home Assistant config and data
  - [ ] 2.4 Configure exposed ports (default 8123) and networking
  - [ ] 2.5 Add environment variables and container configuration options
  - [ ] 2.6 Implement proper systemd dependencies (after NFS mounts)
- [ ] 3.0 Implement Emby Service Module
  - [ ] 3.1 Create modules/services/emby.nix following denix module structure
  - [ ] 3.2 Configure LinuxServer.io Emby container image
  - [ ] 3.3 Set up NFS volume mounts for Emby config and media directories
  - [ ] 3.4 Configure exposed ports (default 8096) and networking
  - [ ] 3.5 Add environment variables for PUID/PGID and timezone
  - [ ] 3.6 Implement proper systemd dependencies (after NFS mounts)
- [ ] 4.0 Create Homelab Containers Feature
  - [ ] 4.1 Create features/homelab.nix module
  - [ ] 4.2 Group Home Assistant and Emby services under the feature
  - [ ] 4.3 Add host validation to ensure feature only works on pudge
  - [ ] 4.4 Include necessary dependencies (podman, NFS client)
- [ ] 5.0 Enable Services on Pudge Host
  - [ ] 5.1 Update hosts/pudge/default.nix to enable homelab feature
  - [ ] 5.2 Verify NFS mount configurations are compatible
  - [ ] 5.3 Test container startup and verify services are accessible
  - [ ] 5.4 Validate data persistence across container restarts
