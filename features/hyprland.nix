{delib, ...}:
delib.module {
  # hyprland desktop and dependencies
  name = "features.hyprland";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    gtk.enable = true;
    programs = {
      _1password.enable = true;
      bruno.enable = true;
      chromium.enable = true;
      firefox.enable = true;
      grimblast.enable = true;
      hyprland.enable = true;
      imv.enable = true;
      kitty.enable = true;
      mpv.enable = true;
      obsidian.enable = true;
      pavucontrol.enable = true;
      pinta.enable = true;
      rofi.enable = true;
      signal.enable = true;
      slack.enable = true;
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
      pipewire.enable = true;
      polkit-gnome.enable = true;
      swayidle.enable = true;
    };
    xdg.enable = true;
    stylix.enable = true;
  };
}
