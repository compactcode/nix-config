{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "services.swayidle";

  options.services.swayidle = with delib; {
    enable = boolOption false;
    # what to do when the system needs to be locked
    lockCommand = strOption "${lib.getExe pkgs.swaylock} -f";
    # what to do when the user is idle
    idle = {
      enable = boolOption false;
      # turn monitors off
      startCommand = strOption "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
      # turn monitors back on
      resumeCommand = strOption "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
    };
  };

  home.ifEnabled = {cfg, ...}: {
    services = {
      swayidle = {
        enable = true;
        events = {
          # hook into loginctl lock-session
          lock = cfg.lockCommand;
          # hook into systemctl suspend
          before-sleep = cfg.lockCommand;
        };
        timeouts =
          [
            {
              # lock after 10 minutes inactivity
              timeout = 60 * 10;
              command = cfg.lockCommand;
            }
          ]
          ++ lib.optionals cfg.idle.enable [
            {
              # idle after 10 minutes inactivity
              timeout = 60 * 15;
              command = cfg.idle.startCommand;
              resumeCommand = cfg.idle.resumeCommand;
            }
          ];
      };
    };
  };
}
