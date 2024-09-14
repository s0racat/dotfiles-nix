```bash
sudo apt update; sudo apt upgrade -y; sudo apt install git curl xz-utils wget -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
mkdir -p ~/ghq/github.com/s0racat/
cd !$
git clone https://github.com/s0racat/dotfiles-nix
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run nixpkgs#home-manager -- switch --impure --flake .#console
```

# gh 

```bash
gh auth login
```

# docker

https://learn.microsoft.com/ja-jp/windows/wsl/systemd

https://docs.docker.com/engine/install/debian/
