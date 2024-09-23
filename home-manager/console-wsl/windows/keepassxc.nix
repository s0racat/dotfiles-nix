{ config, lib, ... }:
let
  ini = lib.generators.toINI { } {
    General = {
      ConfigVersion = 2;
      UpdateCheckMessageShown = true;
    };
    GUI = {
      TrayIconAppearance = "monochrome";
      MinimizeOnStartup = true;
      CheckForUpdates = false;
    };
    SSHAgent = {
      Enabled = true;
      UsePageant = false;
      UseOpenSSH = true;
    };
    Security = {
      IconDownloadFallback = true;
    };
  };
  kpcfg = "/mnt/c/Users/takumi/AppData/Roaming/KeePassXC/keepassxc.ini";

in
{
  home.activation.copyKeePassXCconfig = ''

    cd ~/.mozilla/firefox
    echo 'printf '%s' "${ini}" > ${kpcfg}' > kpxc.sh
    chmod +x kpxc.sh 
  '';
}
