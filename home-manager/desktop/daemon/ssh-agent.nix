
{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.ssh-agent.enable = true;
}
