# Arch Linux packages and config

- [Arch Linux Desktop Environment](#arch-linux-desktop-environment)
- [Arch Linux WSL Environment](#arch-linux-wsl-environment)
- [Config](#config)

## Arch Linux Desktop Environment

### Before everything

```bash
sudo pacman -Syu
```

### Essentials

```bash
sudo pacman -S --needed base-devel nano git curl wget docker docker-compose stow zsh starship mise firewalld ntfs-3g
```

#### AUR Helper

##### YAY

```bash
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

##### PARU

```bash
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### General Applications

```bash
sudo pacman -S --needed mpv firefox gwenview veracrypt qbittorrent krita flatseal noto-fonts-cjk noto-fonts-emoji noto-fonts ffmpegthumbs kdegraphics-thumbnailers
```

### AUR Packages

```bash
sudo yay -S --needed visual-studio-code-bin bibata-cursor-theme-bin
```

```bash
sudo paru -S --needed visual-studio-code-bin bibata-cursor-theme-bin
```

### Laptop

```bash
sudo pacman -S --needed tlp
```

### Terminal Utils

```bash
sudo pacman -S --needed lazydocker lazygit btop fastfetch
```

### Hyperland specific

```bash
sudo yay -S --needed hypridle hyprshot archlinux-xdg-menu noctalia-shell
```

```bash
sudo paru -S --needed hypridle hyprshot archlinux-xdg-menu noctalia-shell
```
## Arch Linux WSL Environment

### Instalar Arch

```bash
wsl --install archlinux
```

### Atualizar o sistema e adicionar mirror brasileiro

```bash
pacman -Syu --noconfirm &&
pacman -S reflector rsync --noconfirm &&
reflector --country Brazil --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
```

### Essentials

```bash
pacman -S --needed base-devel nano git curl wget sudo unzip zip zsh shadow docker docker-compose stow zsh starship mise --noconfirm
```

### Mudar local
  - Abrir com `nano /etc/locale.gen`. Depois pesquise por `en_US.UTF-8 UTF-8` e `pt_BR.UTF-8 UTF-8` e descomente as linhas (Dica, use Ctrl + F).
  - Gere os locais com `locale-gen`.
  - Depois, vá para /etc/locale.conf e coloque:
  ```bash
  LANG=en_US.UTF-8
  LC_ALL=en_US.UTF-8
  ```

### Adicionar usuário

**Atenção!** Trocar pelo seu username
```bash
useradd -m -G wheel -s /bin/zsh USERNAME &&
passwd USERNAME
```

Depois, use `EDITOR=nano visudo` e descomentar a linha `%wheel ALL=(ALL:ALL) ALL` (Dica: use Ctrl + F). Depois disso, use `nano /etc/wsl.conf` e cole isso:

**Atenção!** Trocar pelo seu username
```md
[boot]
systemd=true

[user]
default=USERNAME

[automount]
enabled=true
options=metadata,umask=22,fmask=11
```
Usar `wsl --shutdown` para reiniciar.

## Config

### Git

```bash
git config --global user.name "name"
git config --global user.email email@email.com
```

### Docker

```bash
sudo systemctl enable --now docker && sudo groupadd -f docker && sudo usermod -aG docker $USER
```

### ZSH

```bash
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
chsh -s /bin/zsh
```

### Mise
- Listar versões `mise ls-remote python`
- Usar globalmente uma versão `mise use --global python@3.14`