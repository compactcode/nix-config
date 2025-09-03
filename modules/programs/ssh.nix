{delib, ...}:
delib.module {
  # remote server access
  name = "programs.ssh";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };
}
