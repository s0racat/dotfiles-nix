{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # extraPackages = [ pkgs.gcc ];
    plugins = with pkgs.vimPlugins; 
[
      yankring
        vim-nix
        nord-nvim
         gitsigns-nvim
        ];
        
        };
        }
