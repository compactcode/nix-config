{delib, ...}:
delib.module {
  # version control system
  name = "programs.git";

  options = delib.singleEnableOption false;

  home.ifEnabled = {myconfig, ...}: {
    programs.git = {
      enable = true;
      ignores = [
        "node_modules"
      ];
      settings = {
        init.defaultBranch = "main";
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        user = {
          email = myconfig.users.primary.email;
          name = myconfig.users.primary.name;
        };
      };
    };

    # commands claude can run without asking (push/rebase always ask)
    programs.claude-code.settings.permissions = {
      allow = [
        "Bash(git add:*)"
        "Bash(git blame:*)"
        "Bash(git branch:*)"
        "Bash(git cat-file:*)"
        "Bash(git checkout:*)"
        "Bash(git config get user.name:*)"
        "Bash(git config user.name:*)"
        "Bash(git describe:*)"
        "Bash(git diff:*)"
        "Bash(git fetch:*)"
        "Bash(git grep:*)"
        "Bash(git log:*)"
        "Bash(git ls-files:*)"
        "Bash(git ls-tree:*)"
        "Bash(git merge-base:*)"
        "Bash(git mv:*)"
        "Bash(git reflog:*)"
        "Bash(git remote -v)"
        "Bash(git remote show:*)"
        "Bash(git rev-parse:*)"
        "Bash(git shortlog:*)"
        "Bash(git show:*)"
        "Bash(git stash:*)"
        "Bash(git status:*)"
        "Bash(git tag --list:*)"
        "Bash(git whatchanged:*)"
        "Bash(git worktree list:*)"
      ];
      ask = [
        "Bash(git push:*)"
        "Bash(git rebase:*)"
      ];
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
