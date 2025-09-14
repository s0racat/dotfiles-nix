{ pkgs, ... }:
{

  environment.systemPackages = [

    pkgs.ddcutil
  ];
  hardware.i2c.enable = true;
}
