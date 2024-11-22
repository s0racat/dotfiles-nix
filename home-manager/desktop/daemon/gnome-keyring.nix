{ isNixOS, lib, ... }:
{
  services.gnome-keyring = {
    enable = isNixOS;
    components = [ "ssh" ];
  };
  home.sessionVariables = lib.mkIf isNixOS { SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh"; };
}
