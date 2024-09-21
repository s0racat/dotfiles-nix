```bash
sudo apt update; sudo apt upgrade -y; sudo apt install curl xz-utils -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
mkdir -p ~/ghq/github.com/s0racat/
cd !$
nix-shell -p gitMinimal --run "git clone https://github.com/s0racat/dotfiles-nix"
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run nixpkgs#home-manager switch -- --impure -b backup --flake .#{homeConfig}
```

# gh 

```bash
gh auth login
```

# docker

https://learn.microsoft.com/ja-jp/windows/wsl/systemd

https://docs.docker.com/engine/install/debian/

# systemd user on Debian WSL

```bash
sudo apt install -y dbus-user-session
sudo loginctl enable-linger $USER
```

# install NixOS

```bash
sudo systemctl start wpa_supplicant.service
wpa_cli 
> scan 
> scan_results
> add_network
> set_network 0 ssid "MYSSID"
> set_network 0 psk "passphrase"
> enable_network 0
sudo -i
cgdisk
# NIXBOOT: 500M, LUKS: Remainder of the device
mkfs.fat -F32 -n NIXBOOT $esp
cryptsetup luksFormat -v -i 3000 --label LUKS $luks
cryptsetup open $luks luks
mount /dev/mapper/luks /mnt
mount -m $esp /mnt/boot
nix-shell -p gitMinimal
git clone https://github.com/s0racat/dotfiles-nix
cd dotfiles-nix
nixos-install --flake .#um690pro
reboot

# login with alice, password: 123456
passwd
nmtui
```
