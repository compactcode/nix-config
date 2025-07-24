# 1. Secret Management

* **Status:** Accepted
* **Date:** 2025-07-25

## Context

The project's [vision](../../readme.md#vision) is supported by several [guiding principles](../../readme.md#guiding-principles), including:

*   **Secure:** Prevent and minimize damage from compromised systems by not storing secrets on disk.
*   **Keyboard & Terminal Focused:** Integrate secret management directly into CLI workflows.
*   **Efficiency Focused:** Automate access to credentials to avoid manual copy-pasting.

The challenge is to select a secret management tool that upholds these principles across all required platforms (Linux, macOS, Android) and use cases (browser, CLI, SSH).

The chosen solution must meet the following requirements:

* **Browser Integration:** Must integrate seamlessly with web browsers to autofill credentials.
* **CLI Integration:** Must provide access to secrets for CLI applications.
* **SSH Integration:** Must provide an SSH agent to avoid storing private keys locally.
* **OSX Integration:** Must support system integration (e.g., biometrics) for macOS.
* **Linux Integration:** Must support system integration (e.g., biometrics) for Linux.
* **Android Integration:** Must support Android mobile devices.
* **Vault Synchronization:** Must seamlessly synchronise secrets across devices.

A key constraint is that 1Password is mandated on work devices at my current employer.

## Decision

1Password was chosen as the secret management solution. This decision is based on its ability to meet all technical requirements, existing user familiarity, and the constraint of its mandated use at work, which avoids the complexity of managing two separate password managers.

## Consequences

* **Pros:**
    * It aligns with existing workflows, reducing friction and leveraging deep familiarity with the tool.
* **Cons:**
    * The system will rely on 1Password for all secret management, including its CLI and SSH agent integrations.
    * This introduces a dependency on a closed-source product for a critical security component.
    * Switching to a different provider in the future would require a data migration from 1Password.

## Options Considered

### [1Password](https://1password.com) (Chosen)

* **Pros:**
  * Meets all requirements.
  * Provides [shell-plugins](https://developer.1password.com/docs/cli/shell-plugins/) for seamless CLI use.
  * Extensive user experience with the product over many years.
* **Cons:**
  * Closed source.

### [Bitwarden](https://bitwarden.com)

* **Pros:**
  * Meets all requirements.
  * Open-source.
* **Cons:**
  * Would require migrating data out of 1Password.
  * Would require using multiple password managers since 1Password is mandated at work.
