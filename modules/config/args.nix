{delib, ...}:
delib.module {
  name = "args";

  options.args = with delib; {
    shared = attrsLegacyOption {};
  };

  nixos.always = {cfg, ...}: {
    _module.args = cfg.shared;
  };

  home.always = {cfg, ...}: {
    _module.args = cfg.shared;
  };
}
