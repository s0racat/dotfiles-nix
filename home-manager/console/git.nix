{
  pkgs,
  config,
  ...
}:
{
  programs.git = rec {
    enable = true;
    signing.key = "ECCE3B658A852C82";
    userName = "soracat";
    userEmail = "125882337+s0racat@users.noreply.github.com";
    # signing.signByDefault = true;
    extraConfig = {
      url."https://github.com".pushInsteadOf = "git@github.com";
      ghq.root = "${config.home.homeDirectory}/ghq";
      ghq.user = "s0racat";
      init = {
        defaultBranch = "main";
      };
      core = {
        filemode = false;
      };
    };
    includes = [
      {
        condition = "gitdir:${extraConfig.ghq.root}/gitlab.com/";
        contents = {
          user = {
            name = "Takumi";
            email = "13336500-takuoh@users.noreply.gitlab.com";
            signingkey = signing.key;
          };
        };
      }
    ];
  };

  
}
