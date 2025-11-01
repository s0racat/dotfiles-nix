# Thanks for https://github.com/aiotter/man-pages-ja/blob/cbca572de511f607e0d80c96bce241f4ae93e7ed/flake.nix
{
  stdenvNoCC,
  sources,
  lib,
  perl,
  groff,
}:
let
  inherit (sources) man-pages-ja;
in
stdenvNoCC.mkDerivation {
  inherit (man-pages-ja) src pname version;

  nativeBuildInputs = [ perl ];
  buildInputs = [
    groff
  ];

  patchPhase = ''
    cp script/configure.perl{,.orig}
    export LANG=ja_JP.UTF-8
    cat script/configure.perl.orig | \
    sed \
      -e '/until/ i $ans = "y";' \
      -e "s#/usr/share/man#$out/share/man#" \
      -e 's/install -o $OWNER -g $GROUP/install/' \
      >script/configure.perl
  '';

  configurePhase = ''
    set +o pipefail
    yes "" | make config
  '';
  outputDocdev = "out";

  meta = with lib; {
    homepage = "https://linuxjm.sourceforge.io/";
    description = "Japanese version of man-pages";
    maintainers = with maintainers; [ s0racat ];
    platforms = platforms.all;
  };
}
