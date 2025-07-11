{delib, ...}:
delib.rice {
  name = "catppuccin-mocha";

  # TODO: how do i access stylix here?
  # myconfig.programs.aider.extraConfig = with config.lib.stylix.colors.withHashtag; {
  #   # output style
  #   user-input-color = base0B;
  #   tool-output-color = base05;
  #   tool-error-color = base08;
  #   tool-warning-color = base0A;
  #   assistant-output-color = base0D;
  #   completion-menu-color = base05;
  #   completion-menu-bg-color = base00;
  #   completion-menu-current-color = base00;
  #   completion-menu-current-bg-color = base0D;
  # };

  myconfig.programs.aider.extraConfig = {
    # markdown style
    code-theme = "github-dark";

    completion-menu-bg-color = "#1e1e2e";
    completion-menu-color = "#cdd6f4";
    completion-menu-current-bg-color = "#89b4fa";
    completion-menu-current-color = "#1e1e2e";
    tool-error-color = "#f38ba8";
    tool-output-color = "#cdd6f4";
    tool-warning-color = "#f9e2af";
    user-input-color = "#a6e3a1";
  };
}
