{ pkgs, ... }:
{
  # a = outputs.homeConfigurations."takumi@takumi-Venus-series".config.home.packages
  # lib.unique (builtins.map(x: lib.getName x) a)
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
    unstable.deno
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
  ];
  home.extraDependencies = with pkgs; [
    stdenv
  ];
}
