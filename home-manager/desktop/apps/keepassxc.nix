# apt: require keepassxc
{
  lib,
  config,
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
