let
  envvar = {
    NIXOS_OZONE_WL = "1";
  };
in
{
  home.sessionVariables = envvar;

}
