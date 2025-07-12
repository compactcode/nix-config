{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "services.swayidle";

  options = {myconfig, ...}: {
    services.swayidle = with delib; {
      enable = boolOption myconfig.programs.hyprland.enable;
    };
  };

  home.ifEnabled = {
    services = {
      swayidle = {
        enable = true;
        events = [
          {
            # hook into loginctl lock-session
            event = "lock";
            command = "${lib.getExe pkgs.swaylock} -f";
          }
          {
            # hook into systemctl suspend
            event = "before-sleep";
            command = "${lib.getExe pkgs.swaylock} -f";
          }
        ];
        timeouts = [
          {
            # lock screen after 10 minutes
            timeout = 60 * 10;
            command = "${lib.getExe pkgs.swaylock} -f";
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
