{
  config,
  lib,
  pkgs,
  ...
}:
let
  ini = lib.generators.toINI { } {
    General = {
      ConfigVersion = 2;
      LastOpenedDatabases = ''@Invalid()'';
    };
    Browser = {
      AlwaysAllowAccess = true;
      CustomBrowserLocation = "";
      CustomBrowserType = 2;
      CustomProxyLocation = "";
      Enabled = true;
    };
    GUI = {
      ApplicationTheme = "classic";
      TrayIconAppearnce = "monochrome-light";
    };
    PasswordGenerator = {
      AdditionalChars = "";
      ExcludedChars = "";
    };
    SSHAgent = {
      AuthSockOverride = "";
      Enabled = true;
      SecurityKeyProviderOverride = "";
    };
    Security = {
      IconDownloadFallback = true;
    };
  };
in
{
  home.packages = [ pkgs.keepassxc ];
  home.activation.copyKeePassXCconfig = ''
    if [ ! -d "${config.xdg.configHome}/keepassxc" ]; then 
      mkdir -p "${config.xdg.configHome}/keepassxc"
    fi

    if [ ! -f "${config.xdg.configHome}/keepassxc/keepassxc.ini" ]; then
      echo "${ini}" > "${config.xdg.configHome}/keepassxc/keepassxc.ini"
    fi
  '';
}
