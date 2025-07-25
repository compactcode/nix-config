{
  config,
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.aider";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home = {
      file.".aider.conf.yml".source = with config.lib.stylix.colors.withHashtag;
        (pkgs.formats.yaml {}).generate "aider.conf.yml" {
          # disable automatic commit generation
          auto-commits = false;

          # markdown style
          code-theme = "github-dark";

          # disable prompt to update git ignore
          gitignore = false;

          # avoid warning when using models via github copilot
          show-model-warnings = false;

          # styling with sylix
          user-input-color = base0B;
          tool-output-color = base05;
          tool-error-color = base08;
          tool-warning-color = base0A;
          assistant-output-color = base0D;
          completion-menu-color = base05;
          completion-menu-bg-color = base00;
          completion-menu-current-color = base00;
          completion-menu-current-bg-color = base0D;
        };

      packages = [
        pkgs.aider-chat
      ];
    };

    # hide history from git
    programs.git.ignores = [
      ".aider.chat*"
      ".aider.input*"
      ".aider.tags*"
    ];
  };
}
