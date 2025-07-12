{delib, ...}:
delib.module {
  name = "documentation";

  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    # avoid html documentation
    documentation.doc.enable = false;
  };
}
