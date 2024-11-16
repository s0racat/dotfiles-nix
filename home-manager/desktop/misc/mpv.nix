{
  pkgs,
  lib,
  isNixOS,
  ...
}:
{
  programs.mpv = rec {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;
    scripts = lib.mkIf (package != pkgs.emptyDirectory) [ pkgs.mpvScripts.mpris ];
    config = {
      keep-open = "yes";
      hwdec = "auto";
      ytdl-format = "bestvideo[height<=720][vcodec!=av1]+bestaudio/best";
      gpu-hwdec-interop = "vaapi";
      ao = "pipewire";
    };
  };
  home.packages = [ pkgs.yt-dlp ];
}
