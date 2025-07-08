{delib, ...}:
delib.module {
  # find replacement
  name = "programs.cli.fd";

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
