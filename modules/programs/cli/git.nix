{delib, ...}:
delib.module {
  # version control
  name = "programs.cli.git";

  home.ifEnabled = {myconfig, ...}: {
    programs.git = {
      enable = true;
      extraConfig = {
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
      };
      # use delta for nice diff output
      delta.enable = true;
      ignores = [
        ".aider*"
        ".devenv"
        ".direnv"
        "node_modules"
      ];
      userName = myconfig.constants.username;
      userEmail = myconfig.constants.email;
    };
  };
}
