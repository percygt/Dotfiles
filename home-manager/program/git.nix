{pkgs, ...}: let
  email = "percygt.dev@gmail.com";
  name = "Percy Timon";
  github_repo = "https://github.com/percygt/";
  gitlab_repo = "https://gitlab.com/percygt.dev/";
in {
  home.packages = with pkgs; [
    gh
    glab
  ];
  programs.git = {
    enable = true;
    userEmail = email;
    userName = name;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      ghq = {
        vcs = "git";
        root = "/data/git-repo";
        ${github_repo} = {
          vcs = "git";
          root = "/data/codebox";
        };
        ${gitlab_repo} = {
          vcs = "git";
          root = "/data/codebox";
        };
      };
    };
    aliases = {
      s = "status";
      co = "checkout";
      d = "diff";
      c = "commit";
      p = "pull";
      P = "push";
      b = "branch";
    };
    lfs = {enable = true;};
    diff-so-fancy = {
      enable = true;
    };
    delta = {
      enable = false;
      options = {
        line-numbers = true;
        navigate = true;
      };
    };
    ignores = [
      "*~"
      "*.DS_Store"
      "*.swp"
      "*result*"
      ".direnv"
      "node_modules"
      "**__pycache__**"
      "logs"
      "*.env"
      "venv"
      ".vscode"
    ];
    #signing = {
    #  key = "${config.home.homeDirectory}/.ssh/id_ed25519";
    #  signByDefault = true;
    #};
  };
}
