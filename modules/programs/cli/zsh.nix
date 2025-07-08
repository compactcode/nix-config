{delib, ...}:
delib.module {
  # shell
  name = "programs.cli.zsh";

  home.ifEnabled = {
    programs.zsh = {
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

    home = {
      shellAliases = {
        c = "clear";
        md = "mkdir -p";
      };
    };
  };
}
