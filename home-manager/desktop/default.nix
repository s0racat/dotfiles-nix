{ pkgs, ... }:
{
  imports = [
    ../console/default.nix
  ];
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
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    # noto-fonts-color-emoji
    roboto-mono
    twemoji-color-font
  ];

  fonts = {
    # packages = with pkgs; [
    #   noto-fonts-cjk-sans
    #   noto-fonts-cjk-serif
    #   noto-fonts-color-emoji
    #   roboto-mono
    # ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Sans CJK JP"
        ];
        monospace = [
          "Roboto Mono"
        ];

        emoji = [
          "Twitter Color Emoji"
        ];
      };

    };
  };
  programs.firefox = {
    enable = false;
    profiles = {
      default = {
        bookmarks = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
  };
}
