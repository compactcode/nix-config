{
  delib,
  config,
  lib,
  ...
}:
delib.module {
  # login manager
  name = "services.greetd";

  options = {myconfig, ...}: {
    services.greetd = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  nixos.ifEnabled = {myconfig, ...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
          user = myconfig.users.primary.id;
        };
        # skip first login since boot requires luks password
        default_session = initial_session;
      };
    };
  };
}
