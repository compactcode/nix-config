{delib, ...}:
delib.module {
  name = "services.openssh";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services.openssh = {
      enable = true;
      settings = {
        # public key only
        PasswordAuthentication = false;
        # public key only
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
