```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
git clone https://gitlab.com/takuoh/dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run nixpkgs#home-manager -- switch --flake .#console
```
