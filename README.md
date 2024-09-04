```bash
sudo apt update; sudo apt upgrade -y; sudo apt install git zsh curl xz-utils -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
git clone https://gitlab.com/takuoh/dotfiles-nix
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run nixpkgs#home-manager -- switch --flake .#console
chsh -s $(which zsh)
```
