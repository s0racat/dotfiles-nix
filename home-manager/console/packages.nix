{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
    wget
    grex
    p7zip
    unzip
    rm-improved
    pandoc
    yt-dlp
    jq
    textlint
    commitizen
  ];
  home.extraDependencies = with pkgs; [
    stdenv
  ];
}
