## Instalação e configuração com dotfiles

### Instalar distro do arch

```bash
wsl --install archlinux
```

### Atualizar o sistema e adicionar mirror brasileiro

```bash
pacman -Syu --noconfirm &&
pacman -S reflector rsync --noconfirm &&
reflector --country Brazil --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
```

### Instalar pacotes essenciais

```bash
pacman -S base-devel nano git curl wget sudo unzip zip zsh shadow tree fastfetch --noconfirm
```

### Mudar local
Abrir com `nano /etc/locale.gen`. Depois pesquise por `en_US.UTF-8 UTF-8` e `pt_BR.UTF-8 UTF-8` e descomente as linhas (Dica, use Ctrl + F).

Gere os locais com `locale-gen`.

Depois, vá para /etc/locale.conf e coloque:

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

#### Configuração ZSH

Saia do terminal e abra novamente para entrar com seus usuário (pode ser necessário fazer wsl --shutdown). Irá perguntar sobre o ZSH, apenas aperte `q` para sair.

#### Configuração dos dotfiles

```bash
git clone https://github.com/helpmeagain/dotfiles.git &&
cd dotfiles &&
sudo pacman -S stow --noconfirm &&
stow . -t "$HOME" --no-folding
```

#### Instalar yay

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay &&
cd /tmp/yay &&
makepkg -si --noconfirm
```

#### Instalar ohmyzsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Quando estiver instalando, irá perguntar se quer criar o .zshrc `n` (Pois já terá o .zshrc vindo do dotfile)

#### Instalar ohmyposh

```bash
yay -S oh-my-posh --noconfirm
```

#### Instalar nvm e node

```bash
sudo pacman -S nvm --noconfirm &&
cd &&
source ./.zshrc &&
nvm install --lts
```

### Lembre de reiniciar o PC para garantir que está tudo OK!

## Configurações windows terminal

```json
{
  "colorScheme": "One Half Dark",
  "font": {
    "face": "MesloLGS NF"
  },
  "guid": "{214cdf59-ab91-5045-a308-ea5b3466c983}",
  "hidden": false,
  "name": "archlinux",
  "opacity": 90,
  "source": "Microsoft.WSL",
  "useAcrylic": true
}
```

Baixar [MesloLGS NF](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#fonts)