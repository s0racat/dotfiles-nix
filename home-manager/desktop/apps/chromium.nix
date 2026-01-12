{
  isNixOS,
  lib,
  config,
  self,
  ...
}:
let
  flagsText = builtins.concatStringsSep "\n" (
    (import "${self}/overlays/flags.nix").chromium_flags
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
    ];

  };
  home.activation.writeFlatpakChromiumFlags = lib.mkIf (!isNixOS) (
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          CONFIG_DIR="$HOME/.var/app/org.chromium.Chromium/config"
          CONFIG_FILE="$CONFIG_DIR/chromium-flags.conf"
          mkdir -p "$CONFIG_DIR"

          cat > "$CONFIG_FILE" <<'EOF'
      ${flagsText}
      EOF
    ''
  );
}
