{delib, ...}:
delib.module {
  # grep replacement
  name = "programs.cli.ripgrep";

  home.ifEnabled = {...}: {
    programs.ripgrep = {
      enable = true;
      # exclude git from hidden files
      arguments = [
        "--glob=!.git/*"
      ];
    };
  };
}
