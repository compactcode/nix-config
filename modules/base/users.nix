{
  config,
  delib,
  pkgs,
  homeManagerUser,
  ...
}:
delib.module {
  name = "users";

  options.users.primary = with delib; {
    id = strOption homeManagerUser;
    name = strOption "Shanon McQuay";
    email = strOption "hi@shan.dog";
    sshkey = strOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPCP4SqkSwxkX9dkk36idNz7wCtXfa84hwkkflJVuDF";
  };

  # export 'homeconfig'
  myconfig.always = {cfg, ...}: {
    args.shared.homeconfig = config.home-manager.users.${cfg.primary.id};
  };

  darwin.always = {cfg, ...}: {
    users.users.${cfg.primary.id} = {
      name = cfg.primary.id;
      home = "/Users/${cfg.primary.id}";
    };
  };

  home.always = {cfg, ...}: {
    home = {
      username = cfg.primary.id;
      homeDirectory =
        if pkgs.stdenv.isDarwin
        then "/Users/${cfg.primary.id}"
        else "/home/${cfg.primary.id}";
    };
  };

  nixos.always = {cfg, ...}: {
    users.users.${cfg.primary.id} = {
      isNormalUser = true;
      initialPassword = cfg.primary.id;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        cfg.primary.sshkey
      ];
    };
  };
}
