{ pkgs, config, ... }:
{
  programs.git = rec {
    enable = true;
    userName = "Takumi";
    userEmail = "takuoh@tuta.io";
    signing.key = "ECCE3B658A852C82";
    # signing.signByDefault = true;
    extraConfig = {
      ghq.root = "${config.home.homeDirectory}/ghq";
      init = {
        defaultBranch = "main";
      };
      core = {
        filemode = false;
      };
    };
    includes =
      let
        contents = {
          user = {
            name = "soracat";
            email = "125882337+s0racat@users.noreply.github.com";
            signingkey = signing.key;
          };
        };
      in
      [
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
        {
          condition = "gitdir:${extraConfig.ghq.root}/github.com/";
          inherit contents;
        }
        {
          condition = "gitdir:${config.home.homeDirectory}/dotfiles-nix/";
          inherit contents;
        }
      ];
  };
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  programs.lazygit = {
    enable = true;
  };
  programs.gh = {
    enable = true;
    extensions = [
      pkgs.gh-fzgist
    ];
  };
}
