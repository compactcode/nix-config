{
  delib,
  homeconfig,
  pkgs,
  ...
}:
delib.module {
  # terminal emulator
  # docs: https://sw.kovidgoyal.net/kitty/
  # options: https://searchix.ovh/?query=programs.kitty
  name = "programs.kitty";

  options = {
    programs.kitty = with delib; {
      enable = boolOption false;
      listenSocket = strOption (
        if pkgs.stdenv.isLinux
        then "unix:@kitty"
        else "unix:/tmp/kitty"
      );
    };
  };

  home.ifEnabled = {cfg, ...}: {
    programs.kitty = {
      enable = true;

      keybindings = {
        "alt+e" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh editor";
        "alt+g" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh git";
        "alt+l" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh logs";
        "alt+p" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh processes";
        "alt+s" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh shell";
        "alt+a" = "launch --type=overlay ${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh ai";
      };

      settings = {
        # allow controlling kitty from scripts
        allow_remote_control = "yes";
        # allow using the alt key
        macos_option_as_alt = "both";
        # close when the last shell is closed
        macos_quit_when_last_window_closed = "yes";
        # use socket for remote control
        listen_on = cfg.listenSocket;
      };
    };

    home.shellAliases = {
      ko = "${homeconfig.xdg.configHome}/kitty/scripts/tab-open.sh";
      ks = "${homeconfig.xdg.configHome}/kitty/scripts/tab-send.sh";
    };

    xdg.configFile."kitty/session-basic.conf" = {
      text = ''
        new_tab editor
        launch --hold nvim

        new_tab shell
        launch zsh

        new_tab git
        launch lazygit

        new_tab ai
        launch zsh
      '';
    };

    xdg.configFile."kitty/session-devenv.conf" = {
      text = ''
        new_tab editor
        launch --hold zsh -c "eval $(direnv export bash) && nvim"

        new_tab shell
        launch zsh

        new_tab processes
        launch --hold zsh -c "eval $(direnv export bash) && devenv up"

        new_tab git
        launch --hold zsh -c "eval $(direnv export bash) && lazygit"

        new_tab logs
        launch zsh

        new_tab ai
        launch --hold zsh -c "eval $(direnv export bash) && ai"
      '';
    };

    # automatic styling
    stylix.targets.kitty.enable = true;

    # focus or open tab by title
    xdg.configFile."kitty/scripts/tab-open.sh" = {
      executable = true;
      source = ./scripts/tab-open.sh;
    };

    # send text to tab by title
    xdg.configFile."kitty/scripts/tab-send.sh" = {
      executable = true;
      source = ./scripts/tab-send.sh;
    };
  };
}
