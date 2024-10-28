{
  pkgs,
  config,
  ...

}:
let
  pwd = "${config.home.homeDirectory}/dotfiles-nix/home-manager/console/neovim";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      lua-language-server
      nodePackages.typescript-language-server
      bash-language-server
      vim-language-server
      emmet-language-server
      gopls
      nil
      pyright
      stylua
      nixfmt-rfc-style
      skkDictionaries.l
    ];
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
  };

  xdg.configFile."nvim/lua/conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${pwd}/conf";
  };

}
