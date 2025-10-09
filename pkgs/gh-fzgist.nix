{
  lib,
  stdenvNoCC,
  makeWrapper,
  gh,
  fzf,
  coreutils,
  gawk,
  sources,
}:
let
  binPath = lib.makeBinPath [
    gh
    fzf
    coreutils
    gawk
  ];
  inherit (sources) gh-fzgist;
in
stdenvNoCC.mkDerivation {
  inherit (gh-fzgist) pname src;
  version = lib.substring 0 7 gh-fzgist.version;
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -D -m755 "gh-fzgist" "$out/bin/gh-fzgist"
  '';

  postFixup = ''
    wrapProgram "$out/bin/gh-fzgist" --prefix PATH : "${binPath}"
  '';

  meta = with lib; {
    homepage = "https://github.com/Omochice/gh-fzgist";
    description = "The extension for GitHub CLI to handle gist with fzf";
    maintainers = with maintainers; [ s0racat ];
    license = licenses.mit;
    mainProgram = "gh-fzgist";
    platforms = platforms.all;
  };
}
