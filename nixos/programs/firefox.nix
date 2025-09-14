{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" ];
nativeMessagingHosts.packages= with pkgs; [
      tridactyl-native
      keepassxc
    ];
    autoConfig = ''
      // Use LANG environment variable to choose locale
      // https://gitlab.archlinux.org/archlinux/packaging/packages/firefox/-/blob/72e20d2777ce1f68e57dbffbb16026be43411b82/PKGBUILD#L210-211
      pref("intl.locale.requested", "");
    '';
    policies = {
      ExtensionSettings = {
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "normal_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
        };
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl-vim/latest.xpi";
          installation_mode = "normal_installed";
        };
      };
    };

  };
}
