{
  pkgs,
  config,
  lib,
  ...
}:
let
  fancyWMconfig = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/s0racat/884f0726e0e9b998ab40d3237a8d026d/raw/d9f4315eaeecb41511ee1fd90392b049479f7054/settings.json";
    sha256 = "0s5sdlcjciq0mkly7f3j00skzax3mz4lyavw3wwx1c08d7mzsml5";
  };
  fancyWMpath = "/mnt/c/Users/takumi/AppData/Local/Packages/2203VeselinKaraganev.FancyWM_9x2ndwrcmyd2c/LocalCache/Roaming/FancyWM/settings.json";
  script = "cat ${fancyWMconfig} > ${fancyWMpath}";

in

{
  home.activation.writefancyWMcfg = ''
    cd ~/.mozilla/firefox/
    echo "${script}" > fancywm.sh
    chmod +x fancywm.sh

  '';
}
