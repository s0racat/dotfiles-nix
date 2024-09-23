{
  pkgs,
  config,
  lib,
  ...
}:
let
  wtconfig = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/s0racat/6cc2ce0bbb6fe6b2b43c9b03f9db1959/raw/9e17e75869368f45cd8238f4386b84352a529cae/settings.json";
    sha256 = "148qvd3gzq9w51nirjyjfk7vha43rs1ggr4lv6m58ncjfwz4w1mh";
  };
  wtconfigpath = "/mnt/c/Users/takumi/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
  script = "cat ${wtconfig} > ${wtconfigpath}";
in

{
  home.activation.writeWindowsTerminalcfg = ''
    cd ~/.mozilla/firefox/
    echo "${script}" > wt.sh
    chmod +x wt.sh
  '';
}
