{
  delib,
  homeconfig,
  ...
}:
delib.module {
  # terminal-native agent multiplexer
  # docs: https://herdr.dev/docs/configuration/
  name = "programs.herdr";

  options = delib.singleEnableOption false;

  home.ifEnabled = let
    to = "${homeconfig.xdg.configHome}/herdr/scripts/herdr-tab-open.sh";
    # focus-or-create a tab by title (kitty's alt+e/g/l/p/s/a). ctrl+alt avoids
    # herdr's built-in prefix+e/s/p/g bindings. A non-empty cmd is run when the
    # tab is created (e.g. the ai tab starts claude).
    tabKey = key: label: cmd: {
      inherit key;
      type = "shell";
      command = "${to} ${label}" + (if cmd == "" then "" else " ${cmd}");
    };
  in {
    # package defaults to pkgs.herdr from nixpkgs
    programs.herdr = {
      enable = true;
      settings = {
        onboarding = false;
        # direct chord for the workspace picker, matching the ctrl+alt tab keys
        keys.workspace_picker = "ctrl+alt+w";
        keys.command = [
          (tabKey "ctrl+alt+e" "editor" "")
          (tabKey "ctrl+alt+g" "git" "")
          (tabKey "ctrl+alt+l" "logs" "")
          (tabKey "ctrl+alt+p" "processes" "")
          (tabKey "ctrl+alt+s" "shell" "")
          (tabKey "ctrl+alt+a" "ai" "claude")
          # zoxide/fzf project picker → focus-or-create its workspace
          {
            key = "ctrl+alt+n";
            type = "pane";
            command = "${homeconfig.xdg.configHome}/herdr/scripts/herdr-pick.sh";
          }
        ];
      };
    };

    home.shellAliases = {
      # attach to herdr focused on this dir's workspace (seeding it if new)
      h = "${homeconfig.xdg.configHome}/herdr/scripts/herdr-here.sh";
      # seed a fresh workspace (basic or devenv, auto-detected)
      hb = "${homeconfig.xdg.configHome}/herdr/scripts/herdr-seed.sh";
    };

    # attach, focused on this dir's workspace (focus-or-create + seed)
    xdg.configFile."herdr/scripts/herdr-here.sh" = {
      executable = true;
      source = ./scripts/herdr-here.sh;
    };

    # focus-or-create the workspace for a dir (shared by herdr-here/herdr-pick)
    xdg.configFile."herdr/scripts/herdr-open.sh" = {
      executable = true;
      source = ./scripts/herdr-open.sh;
    };

    # zoxide/fzf project picker → focus-or-create its workspace
    xdg.configFile."herdr/scripts/herdr-pick.sh" = {
      executable = true;
      source = ./scripts/herdr-pick.sh;
    };

    # seed a workspace, mirroring the kitty basic/devenv sessions
    xdg.configFile."herdr/scripts/herdr-seed.sh" = {
      executable = true;
      source = ./scripts/herdr-seed.sh;
    };

    # focus or create a tab by title
    xdg.configFile."herdr/scripts/herdr-tab-open.sh" = {
      executable = true;
      source = ./scripts/herdr-tab-open.sh;
    };
  };
}
