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
    poppler = pkgs."poppler-utils";
    mkPythonWrapper = env: pkgs.writeShellScriptBin "python3" ''
      exec ${env}/bin/python3 "$@"
    '';
  in {
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
          subdir = "skills/engineering";
          filter.nameRegex = "grill-with-docs|improve-codebase-architecture";
        };
      };

      skills.enable = [
        # agent-browser
        "agent-browser"

        # local
        "pr-feedback"
        "pr-rebase"

        # mattpocock-skills
        "grill-with-docs"
        "improve-codebase-architecture"
      ];

      skills.explicit = {
        pdf = {
          from = "anthropic-skills";
          path = "pdf";
          packages = [
            poppler
            pkgs.qpdf
            (mkPythonWrapper (pkgs.python3.withPackages (ps: with ps; [
              pypdf pdfplumber reportlab pytesseract pdf2image
            ])))
          ];
        };
        docx = {
          from = "anthropic-skills";
          path = "docx";
          packages = [
            poppler
            pkgs.pandoc
            (mkPythonWrapper (pkgs.python3.withPackages (ps: with ps; [
              defusedxml
            ])))
          ];
        };
      };

      targets = {
        claude.enable = true;
        gemini.enable = true;
      };
    };
  };
}
