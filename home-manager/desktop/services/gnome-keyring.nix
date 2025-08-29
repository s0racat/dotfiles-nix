{
  isNixOS,
  lib,
  ...
}:
{
  services.gnome-keyring = {
    enable = isNixOS;
    components = [ "ssh" ];
  };
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  systemd.user.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
  xdg.dataFile."keyrings/default" = lib.mkIf isNixOS { text = "login"; };
}
