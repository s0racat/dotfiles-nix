{ pkgs, ... }:
{
  programs.chromium = {
    package = pkgs.stable.chromium;
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
}
