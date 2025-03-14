{
  pkgs,
  lib,
  isNixOS,
  config,
  ...
}:
{
  programs.mpv = {
    enable = true;
    package = lib.mkIf (!isNixOS) pkgs.emptyDirectory;
    scripts = lib.mkIf (config.programs.mpv.package != pkgs.emptyDirectory) [ pkgs.mpvScripts.mpris ];
    config = {
      keep-open = "yes";
      hwdec = "auto";
      ytdl-format = "bestvideo[height<=720][vcodec!=av1]+bestaudio/best";
      gpu-hwdec-interop = "vaapi";
      ao = "pipewire";
    };
  };
}
