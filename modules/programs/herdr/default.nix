{
  delib,
  homeconfig,
  inputs,
  pkgs,
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
    # herdr's built-in prefix+e/s/p/g bindings.
    tabKey = key: label: {
      inherit key;
      type = "shell";
      command = "${to} ${label}";
    };
  in {
    # package from the flake input; nixpkgs may not carry herdr
    programs.herdr = {
      enable = true;
      package = inputs.herdr.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings = {
        onboarding = false;
        # direct chord for the workspace picker, matching the ctrl+alt tab keys
        keys.workspace_picker = "ctrl+alt+w";
        keys.command = [
          (tabKey "ctrl+alt+e" "editor")
          (tabKey "ctrl+alt+g" "git")
          (tabKey "ctrl+alt+l" "logs")
          (tabKey "ctrl+alt+p" "processes")
          (tabKey "ctrl+alt+s" "shell")
          (tabKey "ctrl+alt+a" "ai")
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
