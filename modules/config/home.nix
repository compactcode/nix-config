{
  config,
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "home";

  # export 'homeconfig'
  myconfig.always = {myconfig, ...}: {
    args.shared.homeconfig = config.home-manager.users.${myconfig.constants.username};
  };

  home.always = {myconfig, ...}: let
    inherit (myconfig.constants) username;
  in {
    home = {
      inherit username;
      homeDirectory =
        if pkgs.stdenv.isDarwin
        then "/Users/${username}"
        else "/home/${username}";
    };
  };
}
