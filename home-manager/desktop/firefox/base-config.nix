{
  pkgs,
  config,
  lib,
  ...
}:
{
  # imports = [
  #   ./disable-av1.nix
  # ];
  programs.firefox = {
    enable = true;
    #package = null;
    policies = {
      ExtensionSettings = {
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
    profiles = {
      default = {
        search.default = "DuckDuckGo";
        settings = {
          # Confirm when downloading files
          "browser.download.always_ask_before_handling_new_types" = true;
          # Do not save passwords
          "signon.rememberSignons" = false;
          # Enable HTTPS-Only Mode in all windows
          "dom.security.https_only_mode" = true;
          # Turn off disk cache
          "browser.cache.disk.enable" = false;
          # Do not show warning when opening about:config
          "browser.aboutConfig.showWarning" = false;
          # Disable firefox intro tabs on the first start
          "browser.startup.homepage_override.mstone" = "ignore";
          # Disable Sponsored shortcuts
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          # Do not open "Firefox Privacy Policy" tab in first launch
          "datareporting.policy.firstRunURL" = "";
          # Enable user{Chrome,Content}.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          # Tracking protection
          "privacy.trackingprotection.enabled" = true;
          # WebRTC LAN IP Address
          "media.peerconnection.ice.default_address_only" = true;
          # Disable connection tests
          "network.captive-portal-service.enabled" = false;
          # Disable telemetry
          "toolkit.telemetry.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          # Display bookmarks above search suggestions
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          # Enable Tab Unloading feature
          "browser.tabs.unloadOnLowMemory" = true;
          # Enable fractional scaling via fractional-scale-v1 protocol 
          # "widget.wayland.fractional-scale.enabled" = true;
          # Bring back old Clear All History dialog
          "privacy.sanitize.useOldClearHistoryDialog" = true;
          # Enable verticalTabs
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          # Disable pocket
          "extensions.pocket.enabled" = false;
          # Dark theme
          "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
          # set homepage to about:home
          "browser.startup.homepage" = "about:home";
        };
      };
    };
  };
}
