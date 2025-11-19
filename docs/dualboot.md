## Tutorial

## Troubleshooting

- Problema com horário do Windows e Linux serem diferentes: 
    - Rodar `timedatectl set-local-rtc 1 --adjust-system-clock` no Linux.
    - Ainda pode ser necessário ter que ajustar o horário do Windows uma vez depois disso.

- Retorno de uma suspensão quebrando coisas, como monitores não ligando ou navegadores não respondendo: 
    - Problema da NVidea (https://bbs.archlinux.org/viewtopic.php?id=294326).
    - Rodar `sudo nano /etc/default/grub`.
    - Mudar o parâmetro para `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia.NVreg_PreserveVideoMemoryAllocations=1"` (no caso, apenas adicionar a parte da nvidea)
    - sudo grub-mkconfig -o /boot/grub/grub.cfg

- Timezone não encontrada (DBeaver):
    - Rodar `sudo timedatectl set-timezone America/Sao_Paulo`
