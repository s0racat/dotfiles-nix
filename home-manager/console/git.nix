{
  config,
  ...
}:
{
  programs.delta = {
    enable = true;
    options = {
      features = "side-by-side line-numbers decorations";
      whitespace-error-style = "22 reverse";
      syntax-theme = "Nord";
    };
    enableGitIntegration = true;
  };
  programs.git = rec {
    enable = true;
    signing.key = "ECCE3B658A852C82";
    # signing.signByDefault = true;
    includes = [
      {
        condition = "gitdir:${settings.ghq.root}/gitlab.com/";
        contents = {
          user = {
            name = "Takumi";
            email = "13336500-takuoh@users.noreply.gitlab.com";
            signingkey = signing.key;
          };
        };
      }
    ];
    settings = {
      user = {
        email = "125882337+s0racat@users.noreply.github.com";
        name = "soracat";
      };
      # url."https://github.com".pushInsteadOf = "git@github.com";
      ghq.root = "${config.home.homeDirectory}/ghq";
      ghq.user = "s0racat";
      init = {
        defaultBranch = "main";
      };
      core = {
        filemode = false;
      };

    };

  };

}
