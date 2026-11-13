{
  delib,
  inputs,
  ...
}:
delib.module {
  # declarative agent skill management
  name = "programs.agent-skills";

  options = delib.singleEnableOption false;

  home.always.imports = [inputs.agent-skills-nix.homeManagerModules.default];

  home.ifEnabled = {
    programs.agent-skills = {
      enable = true;

      sources = {
        agent-browser = {
          path = inputs.agent-browser-src;
          subdir = "skills";
          filter.nameRegex = "^agent-browser$";
        };
        anthropic-skills = {
          path = inputs.anthropic-skills;
          subdir = "skills";
        };
        local = {
          path = ./skills;
        };
        mattpocock-skills = {
          path = inputs.mattpocock-skills;
          subdir = "skills/productivity";
          filter.nameRegex = "grilling|teach";
        };
      };

      skills.enable = [
        # agent-browser
        "agent-browser"

        # local
        "pr-feedback"
        "pr-rebase"
        "plainly"

        # mattpocock-skills
        "grilling"
        "teach"
      ];

      targets = {
        claude.enable = true;
        gemini.enable = true;
      };
    };
  };
}
