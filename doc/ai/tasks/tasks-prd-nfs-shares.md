## Relevant Files

- `modules/services/nfs.nix` - New module for configuring NFS client services (autofs and static mounts).
- `hosts/pudge/default.nix` - Host configuration to enable static NFS mounts.
- `hosts/pheonix/default.nix` - Host configuration to enable on-demand NFS mounts.
- `hosts/prophet/default.nix` - Host configuration to enable on-demand NFS mounts.

### Notes

- After making changes, test the configuration by building it for a specific host.
- Use `nh os build` to test the configuration for a Linux host.
- The NFS server is at `192.168.1.200`. Ensure it is reachable from the development machine.
- Refer to `doc/standards/development.md` for more details on project structure and conventions.

## Tasks

- [ ] 1.0 Create a new NixOS module for NFS client configuration.
  - [x] 1.1 Create the file `modules/services/nfs.nix` with the basic `delib.module` structure.
  - [x] 1.2 Define module options to enable NFS and configure a set of shares (e.g., `services.nfs.shares`). Each share should support properties like `remotePath`, `mountPoint`, and `mountType` (`static` or `auto`).
  - [ ] 1.3 Add `pkgs.nfs-utils` to `environment.systemPackages` within the module when it is enabled on NixOS.
- [ ] 2.0 Implement static `systemd` mounts for the `pudge` host.
  - [ ] 2.1 In `nfs.nix`, add logic to generate `fileSystems` entries for shares where `mountType` is `"static"`.
  - [ ] 2.2 Ensure the generated `fileSystems` entry does not include `noauto` or `x-systemd.automount` to facilitate mounting at boot.
  - [ ] 2.3 Remove the hardcoded `fileSystems` NFS configuration from `hosts/pudge/default.nix`.
- [ ] 3.0 Implement on-demand `autofs` mounts for all other Linux hosts.
  - [ ] 3.1 In `nfs.nix`, add logic to enable and configure `services.autofs` for shares where `mountType` is `"auto"`.
  - [ ] 3.2 Generate an autofs map entry for each auto-mounted share, pointing to the correct NFS server path. All on-demand mounts should be located under `/mnt/nfs/`.
- [ ] 4.0 Enable and verify the NFS configuration on all target hosts.
  - [ ] 4.1 In `hosts/pudge/default.nix`, add configuration under `myconfig.services.nfs` to define the `photos` and `documents` shares with `mountType = "static"`.
  - [ ] 4.2 In `hosts/pheonix/default.nix` and `hosts/prophet/default.nix`, add configuration under `myconfig.services.nfs` to define the `photos` and `documents` shares with `mountType = "auto"`.
