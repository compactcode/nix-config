{delib, ...}:
delib.module {
  # version control system
  name = "programs.git";

  options = delib.singleEnableOption false;

  home.ifEnabled = {myconfig, ...}: {
    programs.git = {
      enable = true;
      extraConfig = {
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
      };
      # use delta for nice diff output
      delta.enable = true;
      ignores = [
        ".devenv"
        "node_modules"
      ];
      userName = myconfig.users.primary.name;
      userEmail = myconfig.users.primary.email;
    };

    home = {
      shellAliases = {
        g = "git";
        ga = "git add";
        gars = "git add . && git reset --hard";
        gc = "git commit";
        gca = "git commit --amend";
        gcl = "git clone";
        gcm = "git commit -m";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gd = "git diff";
        gdc = "git diff --cached";
        glg = "git log --stat";
        glr = "git pull --rebase";
        gpo = "git push origin \"$(git symbolic-ref --short HEAD)\"";
        grh = "git reset HEAD";
        grm = "git rm";
        gs = "git status";
      };
    };
  };
}
