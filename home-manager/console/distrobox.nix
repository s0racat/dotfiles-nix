{
  xdg.configFile."distrobox/distrobox.conf".text = ''
    container_user_custom_home="$HOME/distrobox"
    container_manager="podman"
    container_image_default="quay.io/toolbx/arch-toolbox:latest"
    container_name_default="arch"
  '';
}
