{
  lib,
  stdenvNoCC,
  python3Packages,
  gobject-introspection,
  playerctl,
}:

let
  inherit (python3Packages) python pygobject3;
in
stdenvNoCC.mkDerivation rec {
  pname = "playerctl-notify";
  version = "latest";

  src = ./playerctl-notify;
  nativeBuildInputs = [ gobject-introspection ];
  buildInputs = [
    python
    pygobject3
    playerctl
    python3Packages.wrapPython
  ];

  dontBuild = true;

  installPhase = ''
    install -m555 -Dt $out/bin $src/*
  '';

  postFixup = ''
    makeWrapperArgs="\
      --prefix GI_TYPELIB_PATH : $GI_TYPELIB_PATH \
      --prefix PYTHONPATH : \"$(toPythonPath $out):$(toPythonPath ${pygobject3})\""
    wrapPythonPrograms
  '';

  meta = with lib; {
    description = "python script to notify playerctl stop playback";
    homepage = "https://github.com/altdesktop/playerctl";
    license = licenses.lgpl3Only;
    maintainers = [ maintainers.s0racat ];
    platforms = platforms.all;
  };
}
