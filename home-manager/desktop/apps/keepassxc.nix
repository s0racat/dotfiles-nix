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
    CFG_DIR="${config.xdg.configHome}/keepassxc"
    CFG_FILE="$CFG_DIR/keepassxc.ini"

    if [ ! -d "$CFG_DIR" ]; then
      mkdir -p "$CFG_DIR"
    fi

    if [ ! -f "$CFG_FILE" ] || \
       ! printf '%s\n' "${KeePassXCcfg}" | cmp -s - "$CFG_FILE"; then
      printf '%s\n' "${KeePassXCcfg}" >"$CFG_FILE"
      chmod 600 "$CFG_FILE"
    fi
  '';
}
