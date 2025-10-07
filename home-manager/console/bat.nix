{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
  };

}
