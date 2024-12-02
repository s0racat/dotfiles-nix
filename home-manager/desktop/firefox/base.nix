{
  lib,
  pkgs,
  ...
}:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
    };
  };
  programs.firefox = {
    enable = true;
    package = null;

    profiles = {
      default = {
        search = {
          force = true;
          default = "DuckDuckGo";
        };
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
          # force enable vaapi
          "media.ffmpeg.vaapi.enabled" = lib.mkIf pkgs.stdenv.isLinux true;
          # disable av1 by default
          "media.av1.enabled" = lib.mkDefault false;
        };
      };
    };
  };
}
