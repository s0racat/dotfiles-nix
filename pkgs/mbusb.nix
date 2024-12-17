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
  exfatprogs,
}:
let
  binPath = lib.makeBinPath [
    coreutils
    gptfdisk
    curl
    gnutar
    exfatprogs
  ];
in
stdenvNoCC.mkDerivation rec {
  pname = "mbusb";
  version = "851464e";

  src = fetchFromGitHub {
    owner = "s0racat";
    repo = "multibootusb";
    rev = version;
    hash = "sha256-Htp33Wl+8DmuSyxRIf0dRfmSTdrKsEKcwIhF+3KRiRM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    cp -r . $out
  '';

  postFixup = ''
    makeWrapper "$out/makeUSB.sh" "$out/bin/makeUSB.sh" --prefix PATH : "${binPath}" \
      --set GRUB_EFI ${grub2_efi}/bin/grub-install \
      --set GRUB_PC ${grub2}/bin/grub-install
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
