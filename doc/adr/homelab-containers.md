# 2. Homelab Service Deployment Strategy

* **Status:** Accepted
* **Date:** 2025-07-25

## Context

The project's [vision](../../readme.md#vision) calls for a declarative and secure system. To run third-party services like Home Assistant and Emby on the `pudge` homelab server, we need a deployment strategy that aligns with our [guiding principles](../../readme.md#guiding-principles):

*   **Declarative:** The entire service configuration, including specific versions, should be captured in version-controlled Nix code. This allows for reproducible and consistent environments.
*   **Minimal:** The solution should use the simplest possible toolchain, leveraging NixOS's native capabilities rather than adding external tools like Docker Compose.
*   **Secure:** Services must run in isolated containers to protect the host system from potential vulnerabilities.

The challenge is to find a method that meets these criteria while also integrating with existing NFS shares for persistent data storage.

## Decision

We will use NixOS's built-in support for OCI containers (`virtualisation.oci-containers`) with the Podman backend to deploy and manage homelab services.

This approach allows for a fully declarative definition of containers directly within the NixOS configuration. Each service will be defined in its own module, integrating with systemd for lifecycle management and mounting persistent data volumes from the existing NFS shares.

## Consequences

* **Pros:**
    * **Declarative:** Service configurations are version-controlled and reproducible as part of the NixOS system configuration.
    * **Version Pinning:** Allows pinning services to specific container image versions, independent of the `nixpkgs` channel. This provides greater control and stability.
    * **Isolation:** Services run in isolated containers, reducing conflicts and enhancing security.
    * **Integration:** Leverages native NixOS and systemd features for a cohesive system.
    * **Simplicity:** Avoids adding another orchestration tool like Docker Compose or Kubernetes.

* **Cons:**
    * **Platform Lock-in:** The configuration is specific to NixOS and its `oci-containers` module, making it less portable to other operating systems.
    * **Complexity:** Introduces containerization concepts (images, volumes, networking) into the Nix configuration.

## Options Considered

### 1. NixOS OCI Containers (Chosen)

* **Description:** Use the native `virtualisation.oci-containers` NixOS option with the Podman backend.
* **Pros:**
    * Deep integration with the NixOS module system.
    * Fully declarative and reproducible.
    * Allows pinning services to specific image tags, decoupling service versions from `nixpkgs`.
    * Uses systemd for robust service management.
* **Cons:**
    * Configuration is NixOS-specific and not easily portable.

### 2. NixOS nspawn Containers

* **Description:** Create systemd nspawn containers and services using their native NixOS modules (e.g., `services.home-assistant`).
* **Pros:**
    * Potentially the simplest approach if well-maintained modules exist.
* **Cons:**
    * Not all desired services have official or up-to-date NixOS modules.
    * Running specific versions is lot more hassle
    * Provides less isolation and a less portable packaging format than OCI containers.
    * Service versions are tied to the `nixpkgs` channel version.

### 3. Docker Compose

* **Description:** Manage services using a `docker-compose.yml` file, orchestrated by a systemd service.
* **Pros:**
    * `docker-compose.yml` is a widely-known, portable format.
    * Large ecosystem of pre-built images and documentation.
* **Cons:**
    * Less integrated with the declarative nature of NixOS. It's an imperative tool managed by a declarative system.
    * Introduces the Docker daemon as a dependency, which goes against the preference for the simpler, daemonless Podman.
