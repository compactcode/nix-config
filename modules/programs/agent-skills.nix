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

    poppler = pkgs."poppler-utils";
    pdfPythonEnv = pkgs.python3.withPackages (ps: with ps; [
      pypdf pdfplumber reportlab pytesseract pdf2image
    ]);
    pdfPython = pkgs.writeShellScriptBin "python3" ''
      exec ${pdfPythonEnv}/bin/python3 "$@"
    '';
  in {
    programs.agent-skills = {
      enable = true;

      sources = {
        agent-browser = {
          path = "${agent-browser}/etc/agent-browser/skills";
          filter.nameRegex = "^agent-browser$";
        };
        anthropic-skills = {
          path = inputs.anthropic-skills;
          subdir = "skills";
        };
        superpowers = {
          path = inputs.agent-superpowers;
          subdir = "skills";
        };
      };

      skills.enable = [
        "agent-browser"
        "systematic-debugging"
        "test-driven-development"
      ];

      skills.explicit = {
        pdf = {
          from = "anthropic-skills";
          path = "pdf";
          packages = [poppler pkgs.qpdf pdfPython];
        };
        docx = {
          from = "anthropic-skills";
          path = "docx";
          packages = [poppler pkgs.pandoc pdfPython];
        };
      };

      targets = {
        claude.enable = true;
        gemini.enable = true;
      };
    };
  };
}
