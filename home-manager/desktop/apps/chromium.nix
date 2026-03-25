{
  isNixOS,
  lib,
  self,
  ...
}:
let
  flags = import "${self}/overlays/chromium-flags.nix";
  inherit (flags) chromium_flags electron_flags;
  flagsText = builtins.concatStringsSep "\n" chromium_flags;
in
{
  programs.chromium = {
    package = lib.mkIf (!isNixOS) null;
    # https://github.com/nix-community/home-manager/issues/8821
    enable = true;
    extensions = [
      # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # ublock origin lite
      "omkfmpieigblcllmkgbflkikinpkodlk" # enhanced-h264ify
      "bhchdcejhohfmigjafbampogmaanbfkg" # UA Switcher
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      "oboonakemofpalcgghocfoadofidjkkk" # KeePassXC
      "lodcanccmfbpjjpnngindkkmiehimile" # Control Panel for YouTube
    ];

  };
  home.file.".var/app/com.brave.Browser/config/brave-flags.conf".text = flagsText;
  home.file.".local/share/applications/vivaldi-stable.desktop" = lib.mkIf (!isNixOS) {
    text = ''
      [Desktop Entry]
      Version=1.0
      Name=Vivaldi
      # Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
      # From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
      Exec=/usr/bin/vivaldi-stable %U ${toString chromium_flags}
      StartupNotify=true
      Terminal=false
      Icon=vivaldi
      Type=Application
      Categories=Network;WebBrowser;
      MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;
      Actions=new-window;new-private-window;


      [Desktop Action new-window]
      Name=New Window
      Exec=/usr/bin/vivaldi-stable --new-window ${toString chromium_flags}

      [Desktop Action new-private-window]
      Exec=/usr/bin/vivaldi-stable --incognito ${toString chromium_flags}
    '';
  };

  home.file.".local/share/applications/code.desktop" = lib.mkIf (!isNixOS) {
    text = ''
      [Desktop Entry]
      Name=Visual Studio Code
      Comment=Code Editing. Redefined.
      GenericName=Text Editor
      Exec=/usr/bin/code %F ${toString electron_flags}
      Icon=vscode
      Type=Application
      StartupNotify=false
      StartupWMClass=Code
      Categories=TextEditor;Development;IDE;
      MimeType=application/x-code-workspace;
      Actions=new-empty-window;
      Keywords=vscode;

      [Desktop Action new-empty-window]
      Name=New Empty Window
      Exec=/usr/bin/code --new-window %F ${toString electron_flags}
      Icon=vscode
    '';
  };
  home.file.".local/share/applications/code-url-handler.desktop" = lib.mkIf (!isNixOS) {
    text = ''
      [Desktop Entry]
      Name=Visual Studio Code - URL Handler
      Comment=Code Editing. Redefined.
      GenericName=Text Editor
      Exec=/usr/bin/code --open-url %U ${toString electron_flags}
      Icon=vscode
      Type=Application
      NoDisplay=true
      StartupNotify=true
      Categories=Utility;TextEditor;Development;IDE;
      MimeType=x-scheme-handler/vscode;
      Keywords=vscode;
    '';
  };
}
