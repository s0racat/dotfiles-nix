let
  substituteStrings =
    {
      file,
      replacements,
    }:
    let
      fileContent = builtins.readFile file;
      # Replacements には (oldValue, newValue) のペアのリストを渡す
      replacementKeys = map (r: r.old) replacements;
      replacementValues = map (r: r.new) replacements;
    in
    builtins.replaceStrings replacementKeys replacementValues fileContent;
in
substituteStrings
