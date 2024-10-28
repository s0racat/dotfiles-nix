{ pkgs, ... }:
{
  programs.git = rec {
    enable = true;
    # package = pkgs.hello;
    userName = "Takumi";
    userEmail = "takuoh@tuta.io";
    signing.key = "ECCE3B658A852C82";
    # signing.signByDefault = true;
    extraConfig = {
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
          condition = "gitdir:~/ghq/gitlab.com/";
          contents = {
            user = {
              name = "Takumi";
              email = "13336500-takuoh@users.noreply.gitlab.com";
              signingkey = signing.key;
            };
          };
        }
        {
          condition = "gitdir:~/ghq/github.com/";
          inherit contents;
        }
        {
          condition = "gitdir:~/dotfiles-nix/";
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
  programs.gh =
    let
      gh-fzgist = pkgs.callPackage ../../pkgs/gh-fzgist.nix { };
    in
    {
      enable = true;
      extensions = [
        gh-fzgist
      ];
    };
}
