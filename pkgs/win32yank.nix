{
  lib,
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "win32yank";
  version = "0.1.1";

  src = fetchzip {
    url = "https://github.com/equalsraf/win32yank/releases/download/v${version}/win32yank-x64.zip";
    hash = "sha256-4ivE1cYZhYs4ibx5oiYMOhbse9bdOomk7RjgdVl5lD0=";
    stripRoot = false;
  };

  installPhase = ''
    install -D -m755 "win32yank.exe" "$out/bin/win32yank.exe"
  '';

  meta = with lib; {
    homepage = "https://github.com/equalsraf/win32yank";
    description = "Windows clipboard tool";
    maintainers = with maintainers; [ s0racat ];
    license = licenses.isc;
    mainProgram = "win32yank.exe";
    platforms = [ "x86_64-linux" ];
  };
}
