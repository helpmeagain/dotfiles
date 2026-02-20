## Tutorial

## Troubleshooting

- Problema com horário do Windows e Linux serem diferentes: 
    - https://wiki.archlinux.org/title/System_time#UTC_in_Microsoft_Windows

- Timezone não encontrada (DBeaver):
    - Rodar `sudo timedatectl set-timezone America/Sao_Paulo`

- Bluetooth (br-connection-key-missing)
    - https://skshm.in/posts/bluetoothsync/
    - https://wiki.archlinux.org/title/Bluetooth#Dual_boot_pairing

- Montar automaticamente HDD:
    - Verifique se o ntfs-3g está baixado `pacman -Qs ntfs-3g`
    - Crie as pastas de montagem (ex.: /mnt/disk1)
    - Rode `lsblk -f` e copie o UUID do HDD
    - Edite o arquio `/etc/fstab`, seguindo esse modelo caso esteja formatado em NTFS: `UUID=ID-AQUI /mnt/disk1 ntfs-3g defaults,noatime,nofail,uid=1000,gid=1000 0 0`
    - Rode `sudo mount -a` para testar o funcionamento

- Mudar Kernel padrão do grub:
    - Editar com `sudo nano /etc/default/grub`
    - Adicionar `GRUB_TOP_LEVEL="/boot/vmlinuz-linux"` (alterar para kernel desejado)
    - Rodar `sudo grub-mkconfig -o /boot/grub/grub.cfg`

- Salvar a última opção escolhida no grub:
    - Editar com `sudo nano /etc/default/grub`
    - Mudar para `GRUB_DEFAULT=saved`
    - Descomentar a linha `GRUB_SAVEDEFAULT=true`
    - Rodar `sudo grub-mkconfig -o /boot/grub/grub.cfg`

- Secure boot
    - Colocar o Secure Boot em `Setup Mode` na BIOS
    - Baixa sbctl `sudo pacman -S sbctl`
    - Criar chaves com `sbctl create-keys`
    - Use `sudo sbctl status` e verifique se o `Setup Mode` está habilitado e o `Owner GUID` setado
    - Cadastrar chaves `sbctl enroll-keys -m` (IMPORTANTE, a flag `-m` é necessária para dual boot. Caso contrário, pode deixar sem)
    - Instalar Grub novamente. Mude o diretório se for necessário: 
    ```bash
    sudo grub-install \\n  --target=x86_64-efi \\n  --efi-directory=/boot \\n  --bootloader-id=GRUB \\n  --modules="tpm" \\n  --disable-shim-lock
    ```
    - Atualizar GUB com `sudo grub-mkconfig -o /boot/grub/grub.cfg`
    - Assinar arquivos necessários (GRUB, Kernel, etc) com `sudo sbctl verify | sudo sed 's/✗ /sbctl sign -s /e'`
    - Atualizar mkinitcpio `sudo mkinitcpio -P`
    - Verificar as assinaturas com `sudo sbctl list-files`
    - Verificar o status com `sbctl status`
    - Reiniciar o PC e habilitar Secure boot
    - ATENÇÃO: se atualizar qualquer coisa do GRUB, é necessário assinar novamente. O Kernel já será assinado automaticamente com as atualizações