{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  # password manager
  name = "programs.gui.1password";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {
    homebrew = {
      casks = [
        "1password"
      ];
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    programs = {
      # password manager cli
      _1password.enable = true;

      # password manager gui
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [myconfig.constants.username];
      };
    };
  };

  home.ifEnabled = {myconfig, ...}: {
    # allow signing commits with our ssh key
    home.file.".ssh/allowed_signers".text = "* ${myconfig.constants.usersshkey}";

    programs = {
      # configure signing
      git = {
        extraConfig = {
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
          user.signingkey = myconfig.constants.usersshkey;
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
