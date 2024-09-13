let
  concatFiles = files: builtins.concatStringsSep "\n" (map builtins.readFile files);
in
concatFiles
