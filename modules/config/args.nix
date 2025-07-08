{delib, ...}:
delib.module {
  name = "args";

  options.args = with delib; {
    shared = attrsLegacyOption {};
  };

  darwin.always = {cfg, ...}: {
    _module.args = cfg.shared;
  };

  home.always = {cfg, ...}: {
    _module.args = cfg.shared;
  };

  nixos.always = {cfg, ...}: {
    _module.args = cfg.shared;
  };
}
