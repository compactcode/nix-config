# PRD: NFS Client Integration

## 1. Introduction/Overview

This document outlines the requirements for integrating Network File System (NFS) client functionality into the managed environment. The goal is to provide seamless and consistent access to shared files (e.g., photos, documents) hosted on a local NFS server (`192.168.1.200`) from all managed Linux machines.

## 2. Goals

*   To enable access to central NFS shares from all Linux-based systems.
*   To implement a robust mounting strategy that handles different availability requirements for different hosts.
*   To ensure system stability and a smooth user experience, even when the local network or NFS server is unavailable.

## 3. User Stories

*   **As a user on the `pudge` server,** I want NFS shares to be mounted automatically at boot so that services depending on them can start reliably without manual intervention.
*   **As a user on a Linux laptop/desktop,** I want NFS shares to be mounted on-demand when I first try to access them so that my machine boots quickly and does not hang if I'm not on my home network.
*   **As a user on any Linux machine,** I want to access my `photos` and `documents` from the NFS server using a consistent path, as if they were local directories.

## 4. Functional Requirements

1.  NFS client utilities must be installed on all managed Linux systems.
2.  The system must be configured to connect to the NFS server at `192.168.1.200`.
3.  The following NFS shares must be made available:
    *   `/mnt/storage/photos`
    *   `/mnt/storage/documents`
4.  The shares should be mounted at the following client paths to ensure consistency:
    *   `/mnt/nfs/photos`
    *   `/mnt/nfs/documents`
5.  On the host `pudge`, the NFS shares must be mounted automatically at boot time. The boot process may be delayed if the NFS server is unreachable.
6.  On all other Linux hosts, the NFS shares must be mounted on-demand (e.g., using `autofs`).
7.  For on-demand mounts, the system must not hang or delay boot if the NFS server is unavailable. Accessing the mount point should simply fail until the server is reachable.
8.  The system must handle file permissions correctly. The NFS server exports files with user ID `1001` and group ID `1001`. Client systems must ensure the primary user can read and write to the shares.

## 5. Non-Goals (Out of Scope)

*   Configuration of the NFS server itself.
*   NFS client support for non-Linux systems (e.g., macOS).
*   Creation of a dedicated service user on client machines. The configuration will rely on the existing user's permissions, possibly with UID/GID mapping if necessary.

## 6. Technical Considerations

*   A new NixOS module should be created to handle NFS client configuration.
*   The module should allow for specifying different mounting strategies (e.g., static `fstab`/`systemd` vs. `autofs`) on a per-host basis.
*   For static mounts (`pudge`), `systemd` mount and automount units are preferred over direct `/etc/fstab` entries for better dependency management and flexibility.
*   For on-demand mounts, `autofs` should be used.
*   File access for the user might be achieved using the `all_squash` and `anonuid`/`anongid` options on the NFS server, or by mapping UIDs on the client side. The implementation should choose the most robust method.

## 7. Success Metrics

*   After a system rebuild, the directories `/mnt/nfs/photos` and `/mnt/nfs/documents` exist on all Linux hosts.
*   On `pudge`, running `findmnt /mnt/nfs/photos` after boot confirms the share is mounted.
*   On another Linux host, running `ls /mnt/nfs/photos` triggers the mount and successfully lists the directory contents.
*   The primary user can create, modify, and delete files in the mounted directories from any Linux client.

## 8. Open Questions

*   Are there specific NFS version requirements (e.g., v3, v4)?
*   Are there other specific mount options required for performance or security (e.g., `noatime`, `rsize`, `wsize`)?
