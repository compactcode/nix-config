{delib, ...}:
delib.module {
  # web browser
  name = "programs.firefox";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    programs = {
      # web browser, needs kernel keyring access for 1password integration
      firefox.enable = true;
    };
  };
}
