{delib, ...}:
delib.module {
  # markdown viewer
  name = "programs.obsidian";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.obsidian = {
      enable = true;
    };
  };
}
