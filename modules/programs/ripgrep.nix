{delib, ...}:
delib.module {
  # grep replacement
  name = "programs.ripgrep";

  options = delib.singleEnableOption false;

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
