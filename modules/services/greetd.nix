{
  delib,
  config,
  lib,
  ...
}:
delib.module {
  # login manager
  name = "services.greetd";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe' config.programs.hyprland.package "start-hyprland"}";
          user = myconfig.users.primary.id;
        };
        # skip first login since boot requires luks password
        default_session = initial_session;
      };
    };
  };
}
