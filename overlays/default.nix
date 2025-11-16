{ self, inputs, ... }:
final: prev:
# https://wiki.archlinux.org/title/Chromium
let
  electron_flags = [
    "--password-store=gnome-libsecret"
    "--gtk-version=4"
  ];
  chromium_flags = [
    electron_flags
    "--start-maximized"
    "--enable-features=${
      builtins.concatStringsSep "," [
        # "VaapiVideoDecoder"
        # "VaapiIgnoreDriverChecks"
        # "Vulkan"
        # "DefaultANGLEVulkan"
        # "VulkanFromANGLE"
        "WebRTCPipeWireCapturer"
      ]
    }"
    "--force-dark-mode"
  ];
in
{
  stable = import inputs.nixpkgs-small {
    inherit (final) system overlays config;
  };
  chromium = prev.chromium.override { commandLineArgs = chromium_flags; };
  vscode-fhs = (prev.vscode.override { commandLineArgs = electron_flags; }).fhs;
  tmuxPlugins = prev.tmuxPlugins // {
    nord = prev.tmuxPlugins.nord.overrideAttrs (oldAttrs: rec {
      postInstall = (oldAttrs.postInstall or "") + ''
        sed -i '1i#!${prev.stdenv.shell}' $out/share/tmux-plugins/nord/nord.tmux
      '';
    });
  };

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
  man-pages-ja = final.callPackage "${self}/pkgs/man-pages-ja.nix" { };
}
