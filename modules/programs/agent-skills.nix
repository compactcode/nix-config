{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # declarative agent skill management
  name = "programs.agent-skills";

  options = delib.singleEnableOption false;

  home.always.imports = [inputs.agent-skills-nix.homeManagerModules.default];

  home.ifEnabled = let
    agent-browser = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser;
  in {
    programs.agent-skills = {
      enable = true;

      sources = {
        agent-browser = {
          path = "${agent-browser}/etc/agent-browser/skills";
          filter.nameRegex = "^agent-browser$";
        };
        superpowers = {
          path = inputs.agent-superpowers;
          subdir = "skills";
        };
      };

      skills.enable = [
        # agent-browser
        "agent-browser"
        # obra/superpowers
        "systematic-debugging"
        "test-driven-development"
      ];

      targets = {
        claude.enable = true;
        gemini.enable = true;
      };
    };
  };
}
