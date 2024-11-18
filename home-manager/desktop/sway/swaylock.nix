{
  pkgs,
  isNixOS,
  lib,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;

    settings =
      let
        image = toString (
          pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/fd5814f83df436166bbaa68af1d9833181f771f7/wallpapers/kittyboard.png";
            sha256 = "1i32nsf0zlc417w2ra5cxh3rh63lwxwjlgg0sibi05dr5sgj8pxa";
          }
        );
      in
      {
        show-failed-attempts = true;
        show-keyboard-layout = true;
        indicator-caps-lock = true;
        inherit image;
      };
  };
}
