{delib, ...}:
delib.module {
  # find replacement
  name = "programs.fd";

  options = delib.singleEnableOption false;

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
