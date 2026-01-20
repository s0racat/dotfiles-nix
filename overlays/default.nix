{ self, inputs, ... }:
final: prev:
# https://wiki.archlinux.org/title/Chromium
# Mesa 25.0.7: chromium --use-angle=vulkan --enable-features=VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE --disable-features=UseSkiaRenderer
let
  flags = import ./chromium-flags.nix;
  inherit (flags) chromium_flags electron_flags;
in
{
  stable = import inputs.nixpkgs-stable-small {
    inherit (final) overlays config;
    inherit (final.stdenv.hostPlatform) system;
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
