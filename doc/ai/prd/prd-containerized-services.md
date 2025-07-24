# PRD: Containerized Services for Homelab

## Introduction/Overview

This feature adds the capability to run containerized services on the pudge host, specifically Home Assistant and Emby, using NixOS's `virtualisation.oci-containers` with the Podman backend. The services will source their configuration and data from the existing NFS share, providing a declarative and reproducible way to manage homelab container workloads.

The goal is to extend the current nix-config system to support containerized services while maintaining the project's principles of being declarative, minimal, and keyboard-focused.

## Goals

1. Enable declarative management of containerized services through Nix modules
2. Provide secure, isolated execution of Home Assistant and Emby on the pudge host
3. Integrate with existing NFS configuration share for persistent data storage
4. Maintain consistency with existing project structure and conventions
5. Ensure services are automatically started and managed by systemd

## User Stories

- As a homelab administrator, I want to declaratively configure Home Assistant so that my smart home setup is reproducible and version-controlled
- As a media consumer, I want Emby running in a container so that I can stream media while keeping the service isolated from the host system
- As a system administrator, I want all container data stored on the NFS share so that I can easily backup, restore, or migrate services
- As a developer, I want to enable/disable container services through simple Nix configuration so that I can experiment safely

## Functional Requirements

1. **Container Platform Integration**
   - The system must use `virtualisation.oci-containers` with Podman backend
   - The system must integrate with existing NixOS systemd service management
   - The system must support automatic container startup on boot

2. **Service-Specific Modules**
   - The system must provide a dedicated module for Home Assistant configuration
   - The system must provide a dedicated module for Emby configuration
   - Each module must follow the existing denix module structure and conventions
   - The system must use LinuxServer.io container images for consistent, well-maintained images

3. **NFS Integration**
   - The system must mount NFS shares directly into containers as volumes
   - The system must support configurable NFS mount points for each service
   - The system must handle NFS dependency ordering (containers start after NFS mounts)

4. **Host Restrictions**
   - The system must restrict containerized services to the pudge host only
   - The system must validate host compatibility before enabling services
   - The system must provide clear error messages when enabled on unsupported hosts

5. **Configuration Management**
   - Each service module must provide enable/disable options
   - The system must support custom container image versions
   - The system must allow configuration of exposed ports and network settings
   - The system must support environment variable configuration for containers

6. **Data Persistence**
   - All persistent data must be stored on NFS shares
   - The system must support separate data directories for each service
   - The system must handle proper file permissions for container access to NFS

## Non-Goals (Out of Scope)

- Support for other container platforms (Docker, Kubernetes, etc.)
- Support for hosts other than pudge
- Built-in backup/restore functionality (will use existing NFS backup strategy)
- Web UI for container management (will use existing system monitoring tools)
- Support for custom/arbitrary containers beyond Home Assistant and Emby
- Container orchestration or clustering capabilities

## Design Considerations

- Follow existing module structure: `modules/services/homeassistant.nix` and `modules/services/emby.nix`
- Use consistent naming: `services.homeassistant.enable` and `services.emby.enable`
- Integrate with existing NFS client configuration
- Consider creating a shared container services feature for common dependencies
- Ensure proper systemd service dependencies and ordering

## Technical Considerations

- Must depend on existing NFS client module being enabled
- Should validate NFS mount availability before starting containers
- Must handle Podman-specific configuration (rootless vs rootful mode)
- Should consider SELinux/AppArmor implications for NFS access from containers
- Must ensure proper user/group permissions for NFS access
- Consider firewall rules for exposed container ports

## Success Metrics

- Home Assistant container starts successfully and maintains persistent configuration
- Emby container serves media files from NFS share without permission issues
- Services survive host reboots and maintain data persistence
- Configuration changes can be tested through standard `nh os build` workflow
- Zero data loss during container restarts or system updates

## Open Questions

1. Should we create a shared base module for common container service configuration?
2. What specific LinuxServer.io Home Assistant and Emby image versions should be defaults?
3. Do we need health checks or monitoring integration for the containers?
4. Should container logs be integrated with the existing system logging strategy?
5. How should we handle container image updates - automatic or manual?
