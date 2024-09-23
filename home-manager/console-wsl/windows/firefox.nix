{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../../desktop/firefox/base-config.nix
    ../../desktop/firefox/disable-av1.nix
  ];
  programs.firefox = {
    enable = true;
    package = null;
    profiles = {
      default = {
        settings = {
          "font.name.monospace.ja" = "Noto Sans CJK JP";
          "font.name.sans-serif.ja" = "Noto Sans CJK JP";
          "font.name.serif.ja" = "Noto Serif CJK JP";
        };
        userContent = builtins.readFile ./userContent.css;
      };
    };
  };
  home.activation.generatefirefoxScript = ''
    cd ~/.mozilla/firefox
    echo 'cp -r --no-preserve=mode -L default /mnt/c/Users/takumi/AppData/Roaming/Mozilla/Firefox/Profiles
    cp --no-preserve=mode profiles.ini /mnt/c/Users/takumi/AppData/Roaming/Mozilla/Firefox/profiles.ini
    sed -i 's|Path=default|Path=Profiles/default|' /mnt/c/Users/takumi/AppData/Roaming/Mozilla/Firefox/profiles.ini
    eval $BROWSER -p' > firefox.sh
    chmod +x firefox.sh
  '';
}
