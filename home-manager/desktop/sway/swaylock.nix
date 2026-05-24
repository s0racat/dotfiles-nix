# apt: require swaylock
{
  isNixOS,
  lib,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    package = lib.mkIf (!isNixOS) null;

    settings = {
      show-failed-attempts = true;
      show-keyboard-layout = true;
      indicator-caps-lock = true;
      color = "2e3440";
    };
  };
}
