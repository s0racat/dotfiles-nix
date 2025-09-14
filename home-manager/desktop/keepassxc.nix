{
  config,
  lib,
  ...
}:
let
  KeePassXCcfg = lib.generators.toINI { } {
    General = {
      ConfigVersion = 2;
    };
    Browser = {
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
      Enabled = true;
    };
    Security = {
      IconDownloadFallback = false;
    };
  };
in
{
  xdg.configFile."keepassxc/keepassxc.ini".text = KeePassXCcfg;
}
