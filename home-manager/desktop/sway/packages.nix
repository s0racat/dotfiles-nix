{ pkgs, ... }:
{
  home.packages =
    let
      playerctl-notify = pkgs.callPackage ../../../pkgs/playerctl-notify { };
    in
    [
      pkgs.font-awesome_4
      pkgs.i3status-rust
      playerctl-notify
    ];
}
