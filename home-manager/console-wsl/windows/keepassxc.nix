{ config, lib, ... }:
let
  ini = lib.generators.toINI { } {
    General = {
      ConfigVersion = 2;
      UpdateCheckMessageShown = true;
    };
    GUI = {
      TrayIconAppearnce = "monochrome";
      MinimizeOnStartup = true;
      CheckForUpdates = false;
    };
    SSHAgent = {
      Enabled = true;
      UsePagant = false;
      UseOpenSSH = true;
    };
    Security = {
      IconDownloadFallback = true;
    };
  };
in
{
  home.activation.copyKeePassXCconfig =
    let
      kpcfg = "/mnt/c/Users/takumi/AppData/Roaming/KeePassXC/";
    in
    ''
      if [ ! -d "${kpcfg}" ]; then 
        mkdir -p "${kpcfg}"
      fi

      if [ ! -f "${kpcfg}/keepassxc.ini" ]; then
        echo "${ini}" > "${kpcfg}/keepassxc.ini"
      fi
    '';
}
