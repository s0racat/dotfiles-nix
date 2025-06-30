{
  config,
  lib,
  ...
}:
let
  KeePassXCcfg = lib.generators.toINI { } {
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
  home.activation.copyKeePassXCconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -f ${config.xdg.configHome}/keepassxc/keepassxc.ini ]; then
      mkdir -p ${config.xdg.configHome}/keepassxc
      cat << EOF > ${config.xdg.configHome}/keepassxc/keepassxc.ini
    ${KeePassXCcfg}
    EOF
      chmod 600 ${config.xdg.configHome}/keepassxc/keepassxc.ini
    fi
  '';
}
