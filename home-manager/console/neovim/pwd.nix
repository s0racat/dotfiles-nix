{ config, ... }:
let
  pwd = "${config.home.homeDirectory}/dotfiles-nix/home-manager/console/neovim";
in
pwd
