{ ... }:
{
  services.cliphist = {
    enable = true;
    allowImages = true;
    systemdTarget = "sway-session.target";
  };
}
