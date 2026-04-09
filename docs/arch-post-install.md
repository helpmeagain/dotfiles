## Arch Post Install

## Dual boot with Windows

### Dual Boot Troubleshooting

- Problema com horário do Windows e Linux serem diferentes: 
    - https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows

- Bluetooth (br-connection-key-missing)
    - https://wiki.archlinux.org/title/Bluetooth#Dual_boot_pairing
    - https://skshm.in/posts/bluetoothsync/

## Bloquear root
- Usar `sudo passwd -l root`
- Para desbloquear, usar `sudo passwd -u root`

## Snapshots

```bash
sudo pacman -S snapper snap-pac grub-btrfs inotify-tools btrfs-assistant
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
Desabilitar copy-on-write: `sudo chattr +C /diretorio/aqui` (/var/lib/containerd, /var/lib/docker)

## GRUB

- Mudar Kernel padrão do grub:
    - Editar com `sudo nano /etc/default/grub`
    - Adicionar `GRUB_TOP_LEVEL="/boot/vmlinuz-linux"` (alterar para kernel desejado)
    - Rodar `sudo grub-mkconfig -o /boot/grub/grub.cfg`

- Salvar a última opção escolhida no grub:
    - Editar com `sudo nano /etc/default/grub`
    - Mudar para `GRUB_DEFAULT=saved`
    - Descomentar a linha `GRUB_SAVEDEFAULT=true`
    - Rodar `sudo grub-mkconfig -o /boot/grub/grub.cfg`

## Secure boot

- Colocar o Secure Boot em `Setup Mode` na BIOS
- Baixar sbctl `sudo pacman -S sbctl`
- Criar chaves com `sbctl create-keys`
- Use `sudo sbctl status` e verifique se o `Setup Mode` está habilitado e o `Owner GUID` setado
- Cadastrar chaves `sbctl enroll-keys -m` (IMPORTANTE, a flag `-m` é necessária para dual boot. Caso contrário, pode deixar sem)
- Instalar Grub novamente. Mude o diretório se for necessário: 
```bash
sudo grub-install \\n  --target=x86_64-efi \\n  --efi-directory=/boot \\n  --bootloader-id=GRUB \\n  --modules="tpm" \\n  --disable-shim-lock
```
- Atualizar GRUB com `sudo grub-mkconfig -o /boot/grub/grub.cfg`
- Assinar arquivos necessários (GRUB, Kernel, etc) com `sudo sbctl verify | sudo sed 's/✗ /sbctl sign -s /e'`
- Atualizar mkinitcpio `sudo mkinitcpio -P`
- Verificar as assinaturas com `sudo sbctl list-files`
- Verificar o status com `sbctl status`
- Reiniciar o PC e habilitar Secure boot
- ATENÇÃO: se atualizar qualquer coisa do GRUB, é necessário assinar novamente. O Kernel já será assinado automaticamente com as atualizações

## Utils

- Montar automaticamente HDD:
    - Verifique se o ntfs-3g está baixado `pacman -Qs ntfs-3g`
    - Crie as pastas de montagem (ex.: /mnt/disk1)
    - Rode `lsblk -f` e copie o UUID do HDD
    - Edite o arquio `/etc/fstab`, seguindo esse modelo caso esteja formatado em NTFS: `UUID=ID-AQUI /mnt/disk1 ntfs-3g defaults,noatime,nofail,uid=1000,gid=1000 0 0`
    - Rode `sudo mount -a` para testar o funcionamento

- Maquina virtual
    - sudo pacman -Syu qemu virt-manager libvirt dnsmasq ebtables iptables-nft
    - sudo systemctl enable --now libvirtd 
    - sudo usermod -aG libvirt $USER
    - Abrir o virt-manager, ir em file, adicionar conexão e conectar com o QEMU/KVM
    - sudo virsh net-start default
    - sudo virsh net-autostart default
    - Lembrar de verificar firewall

- Local LLM (RADEON GPU)
    - sudo pacman -S ollama-rocm
    - Para baixar os modelos de IA em dispositivo diferente:
        - sudo mkdir -p /mnt/meu_hd/ollama_models
        - sudo chown -R ollama:ollama /mnt/meu_hd/ollama_models
        - sudo systemctl edit ollama.service
        - Adicionar no início do arquivo:
        ```bash
        [Service]
        Environment="OLLAMA_MODELS=/mnt/disk3/ollama_models"
        Environment="OLLAMA_HOST=0.0.0.0"
        Environment="OLLAMA_ORIGINS=*"
        Environment="GPU_MAX_HW_QUEUES=1"
        ```
        - sudo systemctl daemon-reload
        - sudo systemctl restart ollama
    - sudo systemctl enable --now ollama

- Distrobox
    - Instalar: `sudo pacman -S distrobox`
    - Baixar distro: `distrobox create --name ubuntu --image ubuntu:latest`
    - Kali Linux:
        - Baixar Kali: `distrobox create --name kali --image docker.io/kalilinux/kali-rolling`
        - Entrar no Kali: `distrobox enter kali`
        - Defina a senha
        - Configurar teclado e starship: 
        ```bash
        export TERM=xterm
        export DEBIAN_FRONTEND=noninteractive
        sudo -E apt install keyboard-configuration -y
        sudo -E dpkg --configure -a
        sudo -E apt -f install
        sudo apt install starship fzf - y
        exec zsh
        ```
        - Baixar dependências do Kali: `sudo apt install kali-linux-default -y`