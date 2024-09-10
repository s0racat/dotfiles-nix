{
  pkgs,
  lib,
  config,
  ...
}:
let
  isWSL = builtins.getEnv "WSLENV" != "";
  zshConfig = import ./zsh/default.nix {
    inherit
      isWSL
      lib
      config
      pkgs
      ;
  };
  gitConfig = import ./git/default.nix { inherit pkgs isWSL lib; };
  tmuxConfig = import ./tmux/default.nix { inherit pkgs; };
  neovimConfig = import ./neovim/default.nix;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     neovim2 = prev.neovim.override {
  #       configure = {
  #         packages.myVimPackage = with pkgs.vimPlugins; {
  #           opt = [ lazy-nvim ];
  #         };
  #       };
  #     };
  #   })
  # ];

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
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    bat
    eza
    gnupg
    ghq
    gcc
    nodejs
    go
    python3
    lua
    xdg-utils
    ripgrep
    file
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # ".profile".text = ''
    #   if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then source ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    #   if [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then source ~/.nix-profile/etc/profile.d/hm-session-vars.sh; fi
    #   exec ~/.nix-profile/bin/zsh
    # '';
    # ".config/nvim" = {
    #   source = pkgs.fetchFromGitLab {
    #     owner = "takuoh";
    #     repo = "nvim-config";
    #     rev = "HEAD";
    #     sha256 = lib.fakeSha256;
    #   };
    #   recursive = true;
    # };
    ".config/nvim/lua/plugins" = {
      source = mkOutOfStoreSymlink ./neovim/plugins;
      recursive = true;
    };
    ".config/nvim/lua/conf" = {
      source = mkOutOfStoreSymlink ./neovim/conf;
      recursive = true;
    };
  };
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/takumi/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables =
    {
      # EDITOR = "emacs";
    }
    // lib.optionalAttrs isWSL {
      BROWSER = "/mnt/c/Program\\ Files/Mozilla\\ Firefox/firefox.exe";
    };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [
    gitConfig
    zshConfig
    tmuxConfig
    neovimConfig
  ];
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };
  programs.htop = {
    enable = true;
    settings = {
      tree_view = 1;
      tree_view_always_by_pid = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
