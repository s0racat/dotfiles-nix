{ pkgs, ... }:
{
  programs.zsh.shellAliases.clip =
    (pkgs.writeShellScript "clip" ''
      case "$XDG_SESSION_TYPE" in
        x11)
          exec xsel -bi
          ;;
        wayland)
          exec wl-copy
          ;;
        *)
          echo "Unsupported session type: $XDG_SESSION_TYPE" >&2
          exit 1
          ;;
      esac
    '').outPath;
}
