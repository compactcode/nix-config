{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # ai browser automation tool
  name = "programs.agent-browser";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser
    ];
  };
}
