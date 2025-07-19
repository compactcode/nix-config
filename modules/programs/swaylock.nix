{delib, ...}:
delib.module {
  # screen locker
  name = "programs.swaylock";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.swaylock.enable = true;

    # automatic styling
    stylix.targets.swaylock.enable = true;
  };

  nixos.ifEnabled = {
    # allow swaylock to perform authentication
    security.pam.services.swaylock = {};
  };
}
