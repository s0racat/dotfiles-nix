{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_additional_volumes="/nix/store:/nix/store:ro /etc/profiles/per-user:/etc/profiles/per-user:ro /etc/static/profiles/per-user:/etc/static/profiles/per-user:ro"
    container_user_custom_home="$HOME/distrobox"
    container_manager="podman"
    container_image_default="docker.io/library/archlinux:latest"
    container_name_default="arch"
  '';
}
