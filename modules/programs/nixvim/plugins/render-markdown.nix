{delib, ...}:
delib.module {
  # markdown viewer
  name = "programs.nixvim.plugins.render-markdown";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.nixvim.plugins.render-markdown = {
    enable = true;

    settings = {
      file_types = [
        "markdown"
      ];
    };

    # delay loading until opening a markdown file
    lazyLoad.settings.ft = [
      "markdown"
    ];
  };
}
