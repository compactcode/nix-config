{
  config,
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  # password manager
  name = "programs._1password";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "1password"
      ];
    };

    programs = {
      # password manager cli
      _1password.enable = true;
    };

    # 1password replaces the browser password manager and its breach checks
    system.defaults.CustomUserPreferences = let
      policies = {
        PasswordManagerEnabled = false;
        PasswordLeakDetectionEnabled = false;
      };
    in {
      "com.google.Chrome" = policies;
      "org.chromium.Chromium" = policies;
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    programs = {
      # password manager cli
      _1password.enable = true;

      # password manager gui
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [myconfig.users.primary.id];
      };

      # 1password replaces the browser password manager and its breach checks
      chromium.extraOpts = {
        PasswordManagerEnabled = false;
        PasswordLeakDetectionEnabled = false;
      };
    };

    systemd = {
      user.services = {
        # start 1password so the daemon is available
        _1password = {
          description = "1password";
          wantedBy = ["graphical-session.target"];
          wants = ["graphical-session.target"];
          after = ["graphical-session.target"];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${lib.getExe' config.programs._1password-gui.package "1password"} --silent";
          };
        };
      };
    };
  };

  home.ifEnabled = {myconfig, ...}: {
    # allow signing commits with our ssh key
    home.file.".ssh/allowed_signers".text = "* ${myconfig.users.primary.sshkey}";

    programs = {
      # configure signing
      git = {
        # sign commits using an ssh key
        signing.format = "ssh";
        settings = {
          commit.gpgsign = true;
          gpg = {
            ssh = {
              allowedSignersFile = "~/.ssh/allowed_signers";
              program = lib.mkMerge [
                (lib.mkIf pkgs.stdenv.hostPlatform.isLinux "${lib.getExe' config.programs._1password-gui.package "op-ssh-sign"}")
                (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign")
              ];
            };
            format = "ssh";
          };
          user.signingkey = myconfig.users.primary.sshkey;
        };
      };

      # configure ssh
      ssh = {
        enable = true;
        extraConfig = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux ''
            IdentityAgent "~/.1password/agent.sock"
          '')
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin ''
            IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          '')
        ];
      };
    };
  };
}
