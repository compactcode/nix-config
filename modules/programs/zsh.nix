{delib, ...}:
delib.module {
  # shell
  name = "programs.zsh";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs = {
      # use atuin history search
      atuin.enableZshIntegration = true;

      # use direnv for environment management
      direnv.enableZshIntegration = true;

      # use fzf completion
      fzf.enableZshIntegration = true;

      # use starship prompt
      starship.enableZshIntegration = true;

      # use zoxide smarter directory navigation
      zoxide.enableZshIntegration = true;

      zsh = {
        enable = true;
        # auto complete ghost text
        autosuggestion.enable = true;
        prezto = {
          enable = true;
          pmodules = [
            "completion" # auto completion
            "directory" # auto pushd/popd
            "editor" # emacs key bindings
            "history" # history setup
          ];
        };
      };
    };

    home = {
      shellAliases = {
        c = "clear";
        md = "mkdir -p";
      };
    };
  };
}
