{delib, ...}:
delib.module {
  # find replacement
  name = "progams.fd";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.fd = {
      enable = true;
      # show hidden files by default
      hidden = true;
      # exclude git from hidden files
      ignores = [
        ".git/"
      ];
    };
  };
}
