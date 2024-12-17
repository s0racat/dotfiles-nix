{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  gptfdisk,
  curl,
  gnutar,
  grub2,
  grub2_efi,
}:
let
  binPath = lib.makeBinPath [
    coreutils
    gptfdisk
    curl
    gnutar
  ];
in
stdenvNoCC.mkDerivation rec {
  pname = "mbusb";
  version = "b00fb02";

  src = fetchFromGitHub {
    owner = "s0racat";
    repo = "multibootusb";
    rev = version;
    hash = "sha256-OVHN7CGwUW+cVNJ3KfqIGwhjofceiDoEAtQ5HQUGKsU=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    cp -r . $out
  '';

  postFixup = ''
    makeWrapper "$out/makeUSB.sh" "$out/bin/makeUSB.sh" --prefix PATH : "${binPath}" \
      --set GRUB_EFI ${lib.getExe' grub2_efi "grub-install"} \
      --set GRUB_PC ${lib.getExe' grub2 "grub-install"}
    patchShebangs .
  '';

  meta = with lib; {
    homepage = "https://github.com/s0racat/multibootusb";
    description = "A collection of GRUB files and scripts that will allow you to create a pendrive capable of booting different ISO files";
    maintainers = with maintainers; [ s0racat ];
    license = licenses.gpl3;
    mainProgram = "makeUSB.sh";
    platforms = platforms.all;
  };
}
