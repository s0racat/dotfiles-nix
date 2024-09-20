{
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (import ../../overlays/skk-dicts.nix)
  ];

  home.packages = with pkgs; [
    bat
    eza
    gnupg
    ghq
    gcc
    nodejs-slim
    nodePackages.pnpm
    go
    python3
    lua
    xdg-utils
    ripgrep
    file
    deno
    typescript
    fd
    skk-dicts-latest
    wget
  ];

  home.file =
    {
    };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.home-manager.enable = true;
}
