{
  pkgs,
  config,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    twemoji-color-font
    roboto
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {

        sansSerif = [
          "Roboto"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Serif CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Sans CJK JP"
        ];
        emoji = [
          "Twitter Color Emoji"
        ];
      };

    };
  };
}
