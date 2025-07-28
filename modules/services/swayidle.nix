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
    lockCommand = strOption "${pkgs.swaylock}/bin/swaylock -f";
  };

  home.ifEnabled = {cfg, ...}: {
    services = {
      swayidle = {
        enable = true;
        events = [
          {
            # hook into loginctl lock-session
            event = "lock";
            command = cfg.lockCommand;
          }
          {
            # hook into systemctl suspend
            event = "before-sleep";
            command = cfg.lockCommand;
          }
        ];
        timeouts = [
          {
            # lock screen after 10 minutes
            timeout = 60 * 10;
            command = cfg.lockCommand;
          }
          # TODO: Causes issues with swaylock and screen sharing.
          # {
          #   # power off screen after 15 minutes
          #   timeout = 60 * 15;
          #   command = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
          #   resumeCommand = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
          # }
        ];
      };
    };
  };
}
