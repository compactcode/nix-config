{delib, ...}:
delib.module {
  # common cli utilities
  name = "features.cli";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs = {
      atuin.enable = true;
      bat.enable = true;
      btop.enable = true;
      delta.enable = true;
      eza.enable = true;
      fd.enable = true;
      fzf.enable = true;
      git.enable = true;
      jq.enable = true;
      lazygit.enable = true;
      nh.enable = true;
      ouch.enable = true;
      ripgrep.enable = true;
      ssh.enable = true;
      starship.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };
}
