{
  delib,
  homeconfig,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # application launcher
  name = "programs.walker";

  options = delib.singleEnableOption false;

  home.always.imports = [inputs.walker.homeManagerModules.default];

  home.ifEnabled = {
    programs.walker = {
      enable = true;

      package = pkgs.walker; # avoids compiling from source
      runAsService = true;
    };

    programs.elephant = {
      # nixpkgs build ships the provider plugins
      package = pkgs.elephant;
      providers = [
        "bookmarks"
        "calc"
        "clipboard"
        "desktopapplications"
        "files"
        "menus"
        "providerlist"
        "symbols"
        "websearch"
      ];
      provider.bookmarks.settings = {
        location = "${homeconfig.xdg.dataHome}/elephant";
        categories = [
          {
            name = "nixos";
            prefix = "n:";
          }
          {
            name = "personal";
            prefix = "p:";
          }
          {
            name = "zepto";
            prefix = "z:";
          }
        ];
        browsers = [
          {
            name = "firefox";
            command = "hyprctl dispatch \"hl.dsp.focus({ window = 'class:firefox' })\"; systemd-run --user --scope firefox";
          }
        ];
      };
    };

    xdg.dataFile."walker/project.sh" = {
      executable = true;
      source = ./scripts/project.sh;
    };
  };
}
