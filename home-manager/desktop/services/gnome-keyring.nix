{
  isNixOS,
  ...
}:
{
  services.gnome-keyring = {
    enable = isNixOS;
    components = [ "ssh" ];
  };
  # Remove error "loading .xprofile"
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
}
