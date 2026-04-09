{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # local ai transcription app
  name = "programs.handy";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.handy
    ];
  };
}
