{ inputs, pkgs, ... }:
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
        config = ''
          require("lazy").setup(
              "plugins",
              {
                  defaults = {
                      lazy = true
                  },
                  performance = {
                      rtp = {
                          disabled_plugins = {
                              "gzip",
                              "matchit",
                              "tarPlugin",
                              "tohtml",
                              "tutor",
                              "zipPlugin",
                              "health",
                              "netrwPlugin"
                          }
                      }
                  }
              }
          )
        '';
      }

    ];
    extraLuaConfig = ''
      require('conf.options')
      require('conf.keymap')
      require('conf.yank')
    '';
  };
}
