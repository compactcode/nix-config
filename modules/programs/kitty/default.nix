{
  delib,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.kitty";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.kitty = {
      enable = true;

      actionAliases = {
        "focus_tab" = "launch --type=overlay kitty @ focus-tab";
      };

      keybindings = {
        "alt+e" = "focus_tab --match title:^editor$";
        "alt+g" = "focus_tab --match title:^git$";
        "alt+l" = "focus_tab --match title:^logs$";
        "alt+p" = "focus_tab --match title:^processes$";
        "alt+s" = "focus_tab --match title:^shell$";
      };

      settings = {
        # allow controlling kitty from scripts
        allow_remote_control = "yes";
        # allow using the alt key
        macos_option_as_alt = "both";
      };
    };

    home.shellAliases = {
      ko = "${homeconfig.xdg.configFile."kitty/scripts/focus.sh".source}";
    };

    xdg.configFile."kitty/session-basic.conf" = {
      text = ''
        new_tab editor
        launch --hold nvim

        new_tab shell
        launch zsh

        new_tab git
        launch lazygit
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
      '';
    };

    # automatic styling
    stylix.targets.kitty.enable = true;

    # focus or create tab
    xdg.configFile."kitty/scripts/focus.sh" = {
      executable = true;
      source = ./scripts/focus.sh;
    };
  };
}
