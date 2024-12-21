# Debian WSL

<details>
    <summary>Click to open</summary>
    <pre><code>sudo passwd -d takumi
sudo apt update; sudo apt upgrade -y
sudo apt install curl xz-utils zsh -y
sh <(curl -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
nix-shell -p gitMinimal --run "git clone https://github.com/s0racat/dotfiles-nix"
cd dotfiles-nix
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run .#hm-switch -- takumi@debian-wsl
chsh -s $(which zsh)</pre></code>
    <h2>docker</h2>
    <p>https://learn.microsoft.com/ja-jp/windows/wsl/systemd</p>
<p>https://docs.docker.com/engine/install/debian/</p>
    <h2>systemd user</h2>
    <pre><code>sudo apt install -y dbus-user-session
sudo loginctl enable-linger $USER</pre></code>
    <h2>Change /bin/sh symlink to /bin/bash</h2>
    <pre><code>sudo update-alternatives --install /bin/sh sh /bin/bash 100</pre></code>
</details>

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
