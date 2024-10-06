{
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;
    scripts = [ pkgs.mpvScripts.mpris ];
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
