{
  delib,
  lib,
  inputs,
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
            ExecStart = "${lib.getExe' pkgs._1password-gui "1password"} --silent";
          };
        };
      };
    };
  };

  home.always.imports = [inputs._1password-shell-plugins.hmModules.default];

  home.ifEnabled = {myconfig, ...}: {
    # allow signing commits with our ssh key
    home.file.".ssh/allowed_signers".text = "* ${myconfig.users.primary.sshkey}";

    programs = {
      # automatic authentication for cli tools
      _1password-shell-plugins = {
        enable = true;
      };

      # configure signing
      git = {
        settings = {
          commit.gpgsign = true;
          gpg = {
            ssh = {
              allowedSignersFile = "~/.ssh/allowed_signers";
              program = lib.mkMerge [
                (lib.mkIf pkgs.stdenv.isLinux "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}")
                (lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign")
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
          (lib.mkIf pkgs.stdenv.isLinux ''
            IdentityAgent "~/.1password/agent.sock"
          '')
          (lib.mkIf pkgs.stdenv.isDarwin ''
            IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
          '')
        ];
      };
    };
  };
}
