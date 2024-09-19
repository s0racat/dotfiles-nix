{
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (import ../../overlays/skk-dicts.nix)
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
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
