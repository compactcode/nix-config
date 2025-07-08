{delib, ...}:
delib.module {
  # shell
  name = "programs.cli.zsh";

  home.ifEnabled = {
    programs = {
      # use fzf completion
      fzf.enableZshIntegration = true;

      # use starship for prompt
      starship.enableZshIntegration = true;

      # use zoxide for smarter directory navigation
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
