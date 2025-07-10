{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.aider";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home = {
      file.".aider.conf.yml".source = (pkgs.formats.yaml {}).generate "aider.conf.yml" {
        # output style
        # user-input-color = "#${config.lib.stylix.colors.base0B}";
        # tool-output-color = "#${config.lib.stylix.colors.base05}";
        # tool-error-color = "#${config.lib.stylix.colors.base08}";
        # tool-warning-color = "#${config.lib.stylix.colors.base0A}";
        # assistant-output-color = "#${config.lib.stylix.colors.base0D}";
        # completion-menu-color = "#${config.lib.stylix.colors.base05}";
        # completion-menu-bg-color = "#${config.lib.stylix.colors.base00}";
        # completion-menu-current-color = "#${config.lib.stylix.colors.base00}";
        # completion-menu-current-bg-color = "#${config.lib.stylix.colors.base0D}";

        # markdown style
        code-theme = "github-dark";

        # disable automatic commit generation
        auto-commits = false;
      };

      packages = [
        pkgs.aider-chat-with-playwright
      ];
    };
  };
}
