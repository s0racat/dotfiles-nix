final: prev:
let
  electron_flags = [
    "--password-store=gnome-libsecret"
    "--gtk-version=4"
    "--enable-wayland-ime"
    "--wayland-text-input-version=3"
  ];
  chromium_flags = [
    electron_flags
    "--start-maximized"
    "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,WebRTCPipeWireCapturer"
    "--force-dark-mode"
  ];
in
{
  chromium = prev.chromium.override { commandLineArgs = chromium_flags; };
  vscode.fhs = (prev.vscode.override { commandLineArgs = electron_flags; }).fhs;
  # https://github.com/NixOS/nixpkgs/pull/354218
  tmuxPlugins.nord = prev.tmuxPlugins.nord.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        sed -i '1i#!/bin/bash' $out/share/tmux-plugins/nord/nord.tmux
        patchShebangs .
      '';
  });
}
