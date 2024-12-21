{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  makeWrapper,
  coreutils,
  gptfdisk,
  curl,
  gnutar,
  gnused,
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
    gnused
  ];
in
stdenvNoCC.mkDerivation rec {
  pname = "mbusb";
  version = "4693745";

  src = fetchFromGitHub {
    owner = "s0racat";
    repo = "multibootusb";
    rev = version;
    hash = "sha256-4M/sp5DsLJJeQHvZrEYVpiwhIwLPkbb++6Vzudy7/og=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    cp -r . $out
  '';

  postFixup = ''
    makeWrapper "$out/makeUSB.sh" "$out/bin/makeUSB.sh" --prefix PATH : "${binPath}" \
      --set GRUB_EFI ${grub2_efi}/bin/grub-install
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
