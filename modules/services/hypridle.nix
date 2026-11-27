{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "services.hypridle";

  options.services.hypridle = with delib; {
    enable = boolOption false;
    lockCommand = strOption "${lib.getExe' pkgs.procps "pidof"} hyprlock || ${lib.getExe pkgs.hyprlock}";
    idle = {
      enable = boolOption false;
      startCommand = strOption "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch 'hl.dsp.dpms({ action = \"off\" })'";
      resumeCommand = strOption "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch 'hl.dsp.dpms({ action = \"on\" })'";
    };
  };

  home.ifEnabled = {cfg, ...}: {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = cfg.lockCommand;
          before_sleep_cmd = cfg.lockCommand;
          after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch 'hl.dsp.dpms({ action = \"on\" })'";
        };
        listener =
          [
            {
              timeout = 60 * 10;
              on-timeout = cfg.lockCommand;
            }
          ]
          ++ lib.optionals cfg.idle.enable [
            {
              timeout = 60 * 15;
              on-timeout = cfg.idle.startCommand;
              on-resume = cfg.idle.resumeCommand;
            }
          ];
      };
    };
  };
}
