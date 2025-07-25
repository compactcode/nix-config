{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.gemini-cli";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.gemini-cli];
  };
}
