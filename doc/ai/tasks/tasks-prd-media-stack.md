## Relevant Files

- `doc/standards/development.md` - Development standards that must be followed.
- `modules/services/emby.nix` - Existing service module providing useful containerization patterns
- `modules/services/homeassistant.nix` - Existing service module showing NFS mount and systemd dependency patterns
- `modules/services/gluetun.nix` - VPN container module for routing traffic through Mullvad (created)
- `modules/services/prowlarr.nix` - Prowlarr service module (created)
- `modules/services/radarr.nix` - Radarr service module (created)
- `modules/services/sonarr.nix` - Sonarr service module (created)
- `modules/services/transmission.nix` - Transmission service module (to be created)
- `features/homelab.nix` - Feature module to enable the media stack services
- `hosts/pudge/default.nix` - Host configuration to enable the media stack feature

### Notes

- After making changes, test the configuration by building it for the pudge host.
- Use `nh os build` to test the configuration.
- Refer to `doc/standards/development.md` for more details on project structure and conventions.
- All services follow the existing containerization patterns established in `emby.nix` and `homeassistant.nix`
- VPN integration requires careful network configuration to ensure proper traffic routing

## Tasks

- [x] 1.0 Create VPN Infrastructure Module
  - [x] 1.1 Create `modules/services/gluetun.nix` with Mullvad VPN container configuration
  - [x] 1.2 Configure gluetun container with proper environment variables for Mullvad
  - [x] 1.3 Add firewall configuration for VPN container
  - [x] 1.4 Add systemd service dependencies for NFS mounts
  - [x] 1.5 Test VPN container deployment and connectivity

- [ ] 2.0 Implement Core Media Management Services
  - [x] 2.1 Create `modules/services/prowlarr.nix` with proper container configuration
  - [x] 2.2 Configure Prowlarr to use VPN network via gluetun container
  - [x] 2.3 Create `modules/services/radarr.nix` with standard network configuration
  - [x] 2.4 Configure Radarr with proper NFS mounts and dependencies
  - [x] 2.5 Create `modules/services/sonarr.nix` with standard network configuration
  - [ ] 2.6 Configure Sonarr with proper NFS mounts and dependencies

- [ ] 3.0 Implement Download Client Service
  - [ ] 3.1 Create `modules/services/transmission.nix` with VPN network configuration
  - [ ] 3.2 Configure Transmission to use gluetun container network
  - [ ] 3.3 Add proper volume mounts for downloads and media directories
  - [ ] 3.4 Configure Transmission with NFS dependencies

- [ ] 4.0 Configure Service Integration and Dependencies
  - [ ] 4.1 Add Prowlarr and Transmission dependencies to gluetun service
  - [ ] 4.2 Add Prowlarr and Transmission dependencies to Radarr service
  - [ ] 4.3 Add Prowlarr and Transmission dependencies to Sonarr service
  - [ ] 4.4 Verify proper startup order and dependency chain

- [ ] 5.0 Update Feature and Host Configuration
  - [ ] 5.1 Add all media stack services to `features/homelab.nix`
  - [ ] 5.2 Verify pudge host has homelab feature enabled
  - [ ] 5.3 Test complete stack deployment with `nh os build`
  - [ ] 5.4 Validate all services start correctly and in proper order
