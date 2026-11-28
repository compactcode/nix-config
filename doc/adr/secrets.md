# 1. Secret Management

* **Status:** Accepted
* **Date:** 2025-07-25

## Context

Secret management must follow the [guiding principles](../../readme.md#guiding-principles):

* **Secure:** Limit the damage from a compromised system by not storing secrets on disk.
* **Keyboard and terminal focused:** Secrets are available inside CLI workflows.
* **Efficient:** Credentials are filled automatically, with no manual copy and paste.

The tool must:

* Autofill credentials in web browsers.
* Provide secrets to CLI applications.
* Provide an SSH agent, so private keys are not stored locally.
* Integrate with the system, including biometrics, on macOS and Linux.
* Support Android.
* Synchronise secrets across devices.

A key constraint: 1Password is mandated on work devices at my current employer.

## Decision

Use 1Password. It meets every requirement, I already know it well, and using it everywhere avoids running a second password manager alongside the mandated one.

## Consequences

* **Pros:**
    * Fits existing workflows.
    * [Shell plugins](https://developer.1password.com/docs/cli/shell-plugins/) give CLI tools access to secrets.
* **Cons:**
    * A critical security component depends on a closed-source product.
    * Switching provider later requires migrating data out of 1Password.

## Options Considered

### 1. [1Password](https://1password.com) (Chosen)

* **Pros and cons:** See [Consequences](#consequences).

### 2. [Bitwarden](https://bitwarden.com)

* **Pros:**
    * Meets all requirements.
    * Open source.
* **Cons:**
    * Requires migrating data out of 1Password.
    * Means running two password managers, since 1Password is mandated at work.
