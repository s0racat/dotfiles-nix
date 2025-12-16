{ pkgs, ... }:
{
  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  # https://zenn.dev/qitoy/articles/nvim-treesitter-main
  # https://github.com/NixOS/nixpkgs/issues/415438
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
      };
    in
    "${parsers}/parser";
}
