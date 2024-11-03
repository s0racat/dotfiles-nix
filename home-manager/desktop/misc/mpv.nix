{
  pkgs,
  lib,
  ...
}:
let
  isNixOS = (import ../sway/isNixOS.nix).isNixOS;
  scripts = [ pkgs.mpvScripts.mpris ];
  mpvPackage = if scripts == [ ] then pkgs.mpv else (pkgs.mpv.override { scripts = scripts; });
in
{
  xdg.configFile."mpv/mpv.conf".text = lib.generators.toKeyValue { } {
    keep-open = "yes";
    hwdec = "auto";
    ytdl-format = "bestvideo[height<=720][vcodec!=av1]+bestaudio/best";
    gpu-hwdec-interop = "vaapi";
    ao = "pipewire";
  };
  home.packages = [ pkgs.yt-dlp ] ++ lib.optional isNixOS mpvPackage;
}
