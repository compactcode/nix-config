{delib, ...}:
delib.module {
  # cli access to atlassian jira (third party)
  name = "programs.jira-cli";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    homebrew = {
      brews = [
        "jira-cli"
      ];
      taps = [
        "ankitpokhrel/jira-cli"
      ];
    };
  };
}
