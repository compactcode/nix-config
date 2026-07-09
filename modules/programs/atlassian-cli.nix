{
  delib,
  pkgs,
  ...
}:
delib.module {
  # atlassian's official cli (jira, bitbucket, rovo) — unfree
  name = "programs.atlassian-cli";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.acli];
  };
}
