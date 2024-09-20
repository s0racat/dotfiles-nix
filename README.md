```bash
sudo apt update; sudo apt upgrade -y; sudo apt install curl xz-utils -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
mkdir -p ~/ghq/github.com/s0racat/
cd !$
nix-shell -p git --run "git clone https://github.com/s0racat/dotfiles-nix"
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run . -- {homeConfigname}
```

# gh 

```bash
gh auth login
```

# docker

https://learn.microsoft.com/ja-jp/windows/wsl/systemd

https://docs.docker.com/engine/install/debian/

# Debian systemd user

```bash
sudo apt install -y dbus-user-session
sudo loginctl enable-linger $USER
```
