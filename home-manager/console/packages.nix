{ pkgs, ... }:
{
  # a = outputs.homeConfigurations."takumi@takumi-Venus-series".config.home.packages
  # lib.unique (builtins.map(x: lib.getName x) a)
  home.packages = with pkgs; [
    pipr
    eza
    gnupg
    ghq
    gcc
    nodejs_latest
    pnpm
    go
    uv
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
    rip2
    pandoc
    yt-dlp
    jq
    textlint
    nixd
    man-pages-ja
    gemini-cli

  ];
  home.extraDependencies = with pkgs; [
    stdenv
  ];
}
