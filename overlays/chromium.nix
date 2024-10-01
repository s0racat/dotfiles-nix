final: prev:
let
  chromium_flags = [
    "--start-maximized"
    "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,WebRTCPipeWireCapturer"
    "--password-store=gnome-libsecret"
    "--force-dark-mode"
    "--gtk-version=4"
    "--enable-wayland-ime"
    "--wayland-text-input-version=3"
  ];
  electron_flags = [
    "--password-store=gnome-libsecret"
    "--gtk-version=4"
    "--enable-wayland-ime"
    "--wayland-text-input-version=3"
  ];
in
{
  chromium = prev.chromium.override { commandLineArgs = chromium_flags; };
  vscode = prev.vscode.override { commandLineArgs = electron_flags; };
}
