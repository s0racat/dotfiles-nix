{ pkgs, ... }:
{
  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    roboto
    roboto-mono
    nerd-fonts.jetbrains-mono
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  fonts = {
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
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
