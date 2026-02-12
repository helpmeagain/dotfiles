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

- Salvar a última opção escolhida no grub:
    - Editar com `sudo nano /etc/default/grub`
    - Mudar para `GRUB_DEFAULT=saved`
    - Descomentar a linha `GRUB_SAVEDEFAULT=true`
    - Rodar `sudo grub-mkconfig -o /boot/grub/grub.cfg`