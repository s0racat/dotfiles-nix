{
  lib,
  stdenvNoCC,
  sources,
  unzip,
}:
let
  inherit (sources) win32yank;
in
stdenvNoCC.mkDerivation {
  inherit (win32yank) pname;
  nativeBuildInputs = [ unzip ];
  version = lib.removePrefix "v" win32yank.version;

  unpackPhase = ''
    runHook preUnpack

    unzip $src -d $PWD

    runHook postUnpack
  '';
  installPhase = ''
      runHook preInstall


    install -D -m755 "win32yank.exe" "$out/bin/win32yank.exe"
      runHook postInstall
  '';

  src = win32yank.src // {
    stripRoot = false;
  };

  meta = with lib; {
    homepage = "https://github.com/equalsraf/win32yank";
    description = "Windows clipboard tool";
    maintainers = with maintainers; [ s0racat ];
    license = licenses.isc;
    mainProgram = "win32yank.exe";
    platforms = [ "x86_64-linux" ];
  };
}
