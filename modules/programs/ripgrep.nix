{delib, ...}:
delib.module {
  # grep replacement
  name = "progams.ripgrep";

  options = delib.singleEnableOption true;

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
