{ pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    settings = {
      show-failed-attempts = true;
      show-keyboard-layout = true;
      indicator-caps-lock = true;
      image = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/fd5814f83df436166bbaa68af1d9833181f771f7/wallpapers/kittyboard.png";
        sha256 = "1i32nsf0zlc417w2ra5cxh3rh63lwxwjlgg0sibi05dr5sgj8pxa";
      }}";
    };
  };
}
