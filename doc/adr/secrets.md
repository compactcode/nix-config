# Secret Management

## Goal

In alignment with the [guiding principle](../../readme.md#guiding-principles) to build a secure system, no secrets are stored on disk. This includes API keys, tokens, and even SSH keys.

## Requirements

Secrets must be stored in a password manager that meets the following requirements

* **Browser Integration:** Must integrate seamlessly with web browsers to autofill credentials
* **CLI Integration:** Must provide access to secrets for CLI applications
* **SSH Integration:** Must provide an SSH agent to avoint storing private keys locally
* **OSX Integration:** Must support system integration (biometrics etc) for MacOS
* **Linux Integration:** Must support system integration (biometrics etc) for Linux
* **Android Integration:** Must support Android mobile devices
* **Vault Synchronization:** Must seamlessly syncronise secrets across devices

NOTE: 1Password is mandated on work devices at my current employer.

## Options Considered

### [1Password](https://1password.com)

* **Pros**
  * Meets all requirements
  * Provides [shell-plugins](https://developer.1password.com/docs/cli/shell-plugins/) for seamless CLI use
  * Have been happily using it for many years
* **Cons**
  * Closed source

### [Bitwarden](https://bitwarden.com)

* **Pros**
  * Meets all requirements
  * Open-source
* **Cons**
  * Would require migrating data out of 1Password
  * Would require using multiple password managers since 1Password is mandated at work

## Outcome

Due to existing familiarity and mandated usage by my current employer 1password was chosen and integrated.
