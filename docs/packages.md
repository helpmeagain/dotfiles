## Before everything

```bash
sudo pacman -Syu
```

## Essentials

```bash
sudo pacman -S --needed base-devel nano git curl wget docker docker-compose stow zsh starship mise firewalld ntfs-3g
```

### YAY

```bash
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Post install

#### Git

```bash
git config --global user.name "name"
git config --global user.email email@email.com
```

#### Docker

```bash
sudo systemctl enable --now docker && sudo groupadd -f docker && sudo usermod -aG docker $USER
```

#### ZSH

```bash
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
chsh -s /bin/zsh
```

## Snapshots

```bash
sudo pacman -S snapper snap-pac grub-btrfs inotify-tools
yay -S btrfs-assistant
sudo snapper -c root create-config /
sudo snapper -c home create-config /home
sudo snapper -c root set-config ALLOW_USERS="$USER" SYNC_ALL=yes
sudo snapper -c home set-config ALLOW_USERS="$USER" SYNC_ALL=yes
sudo pacman -S mlocate
```

Editar o arquivo updatedb.conf (`sudo nano /etc/updatedb.conf`) e adicionar .snapshots:
`PRUNENAMES = ".git .hg .svn .snapshots"`

Editar o arquivo mkinitcpio.conf (`sudo nano /etc/mkinitcpio.conf`) e adicionar grub-btrfs-overlayfs:
`HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt filesystems fsck grub-btrfs-overlayfs)`

```bash
sudo systemctl enable --now grub-btrfsd.service
sudo snapper -c root create \
  --description "BASELINE - Sistema limpo" \
  --cleanup-algorithm empty

sudo snapper -c home create \
  --description "BASELINE - Home limpa" \
  --cleanup-algorithm empty
```

## General Applications

```bash
sudo pacman -S --needed mpv firefox gwenview veracrypt qbittorrent noto-fonts-cjk noto-fonts-emoji noto-fonts ffmpegthumbs kdegraphics-thumbnailers
```

### AUR

```bash
sudo yay -S --needed visual-studio-code-bin bibata-cursor-theme-bin galaxybudsclient-bin
```

## Terminal Utils

```bash
sudo pacman -S --needed lazydocker lazygit btop fastfetch
```

## Hyperland specific

```bash
sudo pacman -S --needed nwg-displays matugen waybar hypridle hyprlock hyprshot swww brightnessctl pavucontrol bluetui rofi archlinux-xdg-menu
```

## Laptop

```bash
sudo pacman -S --needed tlp
```
