{ pkgs, ... }:
{

  xdg.dataFile."gnome-shell/extensions/pop-shell@system76.com".source =
    "${pkgs.gnomeExtensions.pop-shell}/share/gnome-shell/extensions/pop-shell@system76.com";

}
