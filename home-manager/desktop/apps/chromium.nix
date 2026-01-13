{
  isNixOS,
  lib,
  config,
  self,
  ...
}:
let
  flags = import "${self}/overlays/flags.nix";
inherit (flags) chromium_flags;
  flagsText = builtins.concatStringsSep "\n" (
    chromium_flags
    ++ [ "--user-data-dir=${config.home.homeDirectory}/.config/chromium" ]
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
  home.activation.writeFlatpakChromiumFlags = lib.mkIf (!isNixOS) (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      CONFIG_DIR="$HOME/.var/app/org.chromium.Chromium/config"
      CONFIG_FILE="$CONFIG_DIR/chromium-flags.conf"

      if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
      fi

      if [ ! -f "$CONFIG_FILE" ] || \
         ! printf '%s\n' "${flagsText}" | cmp -s - "$CONFIG_FILE"; then
        printf '%s\n' "${flagsText}" >"$CONFIG_FILE"
      fi
    ''
  );
}
