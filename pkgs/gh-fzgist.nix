{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  makeWrapper,
  gh,
  fzf,
  coreutils,
  gawk,
}:
let
  binPath = lib.makeBinPath (
    [
      gh
      fzf
      coreutils
      gawk
    ]
  );
in
stdenvNoCC.mkDerivation rec {
  pname = "gh-fzgist";
  version = "0-unstable-2021-12-11";

  src = fetchFromGitHub {
    owner = "Omochice";
    repo = "gh-fzgist";
    rev = "e2d20a91bbd19de1dc1cd8c603b366dd63c92158";
    hash = "sha256-Cweij9Y1qfoqBI8UumTzbMbXDjeqJc3ytISFir7g4Vg=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    mkdir $out
      install -D -m755 "gh-fzgist" "$out/bin/gh-fzgist"
  '';

  postFixup = ''
    wrapProgram "$out/bin/gh-fzgist" --prefix PATH : "${binPath}"
  '';

  meta = with lib; {
    homepage = "https://github.com/Omochice/gh-fzgist";
    description = "The extension for GitHub CLI to handle gist with fzf";
    maintainers = with maintainers; [ s0racat ];
    license = licenses.unlicense;
    mainProgram = "gh-fzgist";
    platforms = platforms.all;
  };
}

