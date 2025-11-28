{delib, ...}:
delib.module {
  # version control system
  name = "programs.jujutsu";

  options = delib.singleEnableOption false;

  home.ifEnabled = {myconfig, ...}: {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          email = myconfig.users.primary.email;
          name = myconfig.users.primary.name;
        };
        # defalt command when using jj
        ui.default-command = "log";
      };
    };
  };
}
