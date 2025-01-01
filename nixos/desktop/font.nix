{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      twemoji-color-font
      roboto
      roboto-mono
      # unstable
      # nerd-fonts.jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Roboto"
          "Noto Sans CJK JP"
        ];
        serif = [ "Noto Serif CJK JP" ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };
}
