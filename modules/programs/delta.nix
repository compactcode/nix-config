{delib, ...}:
delib.module {
  # diff viewer
  name = "programs.delta";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs = {
      delta = {
        enable = true;
        enableGitIntegration = true;
      };
    };
  };
}
