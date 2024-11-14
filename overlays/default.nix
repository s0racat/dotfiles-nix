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
  libskk = prev.libskk.overrideAttrs {
    patches = [
      # fix parse error in default.json
      # https://github.com/ueno/libskk/pull/90
      (prev.fetchpatch {
        url = "https://github.com/ueno/libskk/commit/2382ebedc8dca88e745d223ad7badb8b73bbb0de.diff";
        sha256 = "sha256-e1bKVteNjqmr40XI82Qar63LXPWYIfnUVlo5zQSkPNw=";
      })
    ];

  };
  tmuxPlugins.nord = prev.tmuxPlugins.nord.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        sed -i '1i#!/bin/bash' $out/share/tmux-plugins/nord/nord.tmux
        patchShebangs .
      '';
  });
}
