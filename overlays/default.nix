{ self }:
final: prev:
# https://wiki.archlinux.org/title/Chromium
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
    "--enable-features=${
      builtins.concatStringsSep "," [
        "VaapiVideoDecoder"
        "VaapiIgnoreDriverChecks"
        "Vulkan"
        "DefaultANGLEVulkan"
        "VulkanFromANGLE"
        "WebRTCPipeWireCapturer"
      ]
    }"
    "--force-dark-mode"
  ];
in
{
  chromium = prev.chromium.override { commandLineArgs = chromium_flags; };
  vscode.fhs = (prev.vscode.override { commandLineArgs = electron_flags; }).fhs;
  tmuxPlugins.nord = prev.tmuxPlugins.nord.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      sed -i '1i#!${prev.stdenv.shell}' $out/share/tmux-plugins/nord/nord.tmux
    '';
  });
  # https://github.com/NixOS/nixpkgs/pull/426978/files
  papirus-nord = prev.papirus-nord.overrideAttrs (_: {
    dontFixup = true;
    dontDropIconThemeCache = true;
  });
  # tmux = prev.tmux.overrideAttrs (oldAttrs: {
  #   src = prev.fetchFromGitHub {
  #     owner = "tmux";
  #     repo = "tmux";
  #     rev = "3e28777";
  #     hash = "sha256-EIytv4wIxLnvTE9fXIJIbrxABAaEHnHpQ9irc3bRxSI=";
  #   };
  # });

  sources = final.callPackage "${self}/_sources/generated.nix" { };
  gh-fzgist = final.callPackage "${self}/pkgs/gh-fzgist.nix" { };
  playerctl-notify = final.callPackage "${self}/pkgs/playerctl-notify" { };
  mbusb = final.callPackage "${self}/pkgs/mbusb.nix" { };
  win32yank = final.callPackage "${self}/pkgs/win32yank.nix" { };
}
