{delib, ...}:
delib.module {
  # ls replacement
  name = "progams.eza";

  options = delib.singleEnableOption true;

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
