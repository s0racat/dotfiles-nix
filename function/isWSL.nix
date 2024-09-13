let
  isWSL = builtins.getEnv "WSLENV" != "";
in
isWSL
