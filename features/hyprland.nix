{delib, ...}:
delib.module {
  # hyprland desktop and dependencies
  name = "features.hyprland";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs = {
      grimblast.enable = true;
      hyprland.enable = true;
      imv.enable = true;
      mpv.enable = true;
      pavucontrol.enable = true;
      rofi.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
      yazi.enable = true;
      zathura.enable = true;
    };
    services = {
      cliphist.enable = true;
      greetd.enable = true;
      hyprpaper.enable = true;
      mako.enable = true;
      polkit-gnome.enable = true;
      swayidle.enable = true;
    };
  };
}
