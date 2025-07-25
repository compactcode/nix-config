{delib, ...}:
delib.module {
  name = "editorconfig";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          trim_trailing_whitespace = true;
          indent_style = "space";
          indent_size = 2;
        };
      };
    };
  };
}
