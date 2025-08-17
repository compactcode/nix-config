{delib, ...}:
delib.module {
  name = "hosts";

  options = with delib; let
    host = {
      options = hostSubmoduleOptions;
    };
  in {
    host = hostOption host;
    hosts = hostsOption host;
  };

  home.always = {myconfig, ...}: {
    assertions = delib.hostNamesAssertions myconfig.hosts;
  };
}
