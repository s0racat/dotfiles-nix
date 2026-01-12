let
  electron_flags = [
    "--password-store=gnome-libsecret"
    "--gtk-version=4"
  ];
  chromium_flags = electron_flags ++ [
    "--start-maximized"
    "--enable-features=${
      builtins.concatStringsSep "," [
        "AcceleratedVideoDecodeLinuxGL"
        "WebRTCPipeWireCapturer"
      ]
    }"
    "--force-dark-mode"
  ];
in
{
  inherit chromium_flags electron_flags;
}
