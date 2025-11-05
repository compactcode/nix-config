{
  delib,
  pkgs,
  ...
}:
delib.module {
  # cli access to atlassian products
  name = "programs.atlassian-cli";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.atlassian-cli];
  };
}
