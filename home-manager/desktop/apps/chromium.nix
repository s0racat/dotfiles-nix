{
  isNixOS,
  lib,
  self,
  ...
}:
let
  flags = import "${self}/overlays/chromium-flags.nix";
  inherit (flags) chromium_flags;
  flagsText = builtins.concatStringsSep "\n" (
    chromium_flags
  );
in
{
  programs.chromium = {
    package = lib.mkIf (!isNixOS) null;
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
}
