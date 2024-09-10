{ pkgs, ... }:
{
  imports = [
    # inputs.nixvim.homeManagerModules.nixvim
    # ./plugins/lazy-nvim.nix
  ];
  # programs.nixvim = {
  #   enable = true;
  #   plugins.lazy.enable = true;
  # };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # extraLuaPackages = luaPkgs: with luaPkgs; [ 
    #   luarocks
    #  ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = lazy-nvim;
        type = "lua";
        config = builtins.readFile ./lazy-nvim.lua;
      }

    ];
    extraLuaConfig = ''
      require('conf.options')
      require('conf.keymap')
      require('conf.yank')
    '';
  };
}
