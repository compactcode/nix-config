{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai assistant
  name = "programs.aider";

  options.programs.aider = with delib; {
    enable = boolOption true;
    extraConfig = attrsOption {};
  };

  home.ifEnabled = {cfg, ...}: {
    home = {
      file.".aider.conf.yml".source =
        (pkgs.formats.yaml {}).generate "aider.conf.yml" {
          # disable automatic commit generation
          auto-commits = false;
        }
        // cfg.extraConfig;

      packages = [
        pkgs.aider-chat-with-playwright
      ];
    };
  };
}
