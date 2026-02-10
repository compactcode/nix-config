{delib, ...}:
delib.module {
  # ai assistant
  name = "programs.opencode";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        # prevent data leaks
        share = "disabled";
        # update via nix
        autoupdate = false;
      };
    };
  };
}
