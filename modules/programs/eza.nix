{delib, ...}:
delib.module {
  # ls replacement
  name = "programs.eza";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.eza = {
      enable = true;
    };

    home = {
      shellAliases = {
        l = "eza -la --icons --no-permissions --no-user";
        la = "eza -la";
        ll = "eza -la --icons";
        lt = "eza -l --tree";
      };
    };
  };
}
