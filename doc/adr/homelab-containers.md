# 2. Homelab Service Deployment

* **Status:** Accepted
* **Date:** 2025-07-25

## Context

The `pudge` homelab server runs third-party services such as Home Assistant and Emby, with data on existing NFS shares. The deployment method must follow the [guiding principles](../../readme.md#guiding-principles):

* **Declarative:** Service configuration, including versions, lives in version-controlled Nix code.
* **Minimal:** Use what NixOS provides rather than adding tools such as Docker Compose.
* **Secure:** Services run in isolated containers to protect the host.

## Decision

Deploy homelab services with NixOS's built-in OCI container support (`virtualisation.oci-containers`) on the Podman backend. Each service has its own module, is managed by systemd and mounts its data from the NFS shares.

## Consequences

* **Pros:**
    * Services are declared in the NixOS configuration, so they are version-controlled and reproducible.
    * Image versions are pinned per service, independent of `nixpkgs`.
    * Services are isolated from the host and from each other.
    * No extra orchestration tool is needed.
* **Cons:**
    * The configuration is specific to NixOS and does not port to other systems.
    * Container concepts (images, volumes, networking) enter the Nix configuration.

## Options Considered

### 1. NixOS OCI Containers (Chosen)

* **Description:** The native `virtualisation.oci-containers` option with the Podman backend.
* **Pros and cons:** See [Consequences](#consequences).

### 2. NixOS Service Modules

* **Description:** Run each service through its native NixOS module, e.g. `services.home-assistant`.
* **Pros:**
    * The simplest approach where a well-maintained module exists.
* **Cons:**
    * Not every service has an up-to-date NixOS module.
    * Service versions are tied to `nixpkgs`, and pinning a specific version is awkward.
    * Less isolation than OCI containers.

### 3. Docker Compose

* **Description:** Manage services with a `docker-compose.yml` file, run by a systemd service.
* **Pros:**
    * A widely known, portable format.
    * A large ecosystem of images and documentation.
* **Cons:**
    * An imperative tool inside a declarative system.
    * Adds the Docker daemon, where Podman is daemonless.
