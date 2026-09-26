{
  delib,
  pkgs,
  ...
}:
delib.module {
  # ai browser automation tool
  name = "programs.agent-browser";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      pkgs.agent-browser
    ];
  };

  nixos.ifEnabled = {
    # agent-browser auto-downloads a generic-linux Chrome build on first
    # launch; that binary's dynamic linker path doesn't exist on NixOS, so
    # it fails with exit code 127. Point it at nixpkgs' patched chromium.
    environment.sessionVariables = {
      AGENT_BROWSER_EXECUTABLE_PATH = "${pkgs.chromium}/bin/chromium";
    };
  };
}
