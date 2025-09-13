# Debian WSL

```bash
sudo passwd -d takumi
sudo apt update; sudo apt upgrade -y
sudo apt install curl xz-utils zsh -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
nix-shell -p gitMinimal --run "git clone https://github.com/s0racat/dotfiles-nix"
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
# set HM variable to override home-manager profile
nix run
chsh -s $(which zsh)
```

## docker

[https://learn.microsoft.com/ja-jp/windows/wsl/systemd](https://learn.microsoft.com/ja-jp/windows/wsl/systemd)

[https://docs.docker.com/engine/install/debian/](https://docs.docker.com/engine/install/debian/)


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
device=/dev/nvme0n1
cgdisk $device
# NIXBOOT: 500M, LUKS: Remainder of the device
luks=${device}p2
esp=${device}p1
mkfs.fat -F32 -n NIXBOOT $esp
cryptsetup luksFormat -v --label LUKS $luks
cryptsetup open $luks luks
mkfs.ext4 -L NIXROOT /dev/mapper/luks
mount /dev/mapper/luks /mnt
mount -m $esp /mnt/boot
# to setup secureboot, see https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md

nix-shell -p gitMinimal
git clone https://github.com/s0racat/dotfiles-nix
cd dotfiles-nix
nixos-install --flake .#um690pro
reboot

# login with takumi, password: 123456
passwd
nmtui
sudo systemd-cryptenroll --tpm2-device=auto $luks
```

# gh

```bash
gh auth login
```
