{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai browser automation tool
  name = "programs.agent-browser";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      pkgs.agent-browser
    ];
  };
}
