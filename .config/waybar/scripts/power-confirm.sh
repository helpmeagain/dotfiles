#!/bin/bash

ACTION=$1
MESSAGE=""

case $ACTION in
  poweroff)
    MESSAGE="Deseja realmente desligar o sistema?"
    ;;
  reboot)
    MESSAGE="Deseja realmente reiniciar o sistema?"
    ;;
  logout)
    MESSAGE="Deseja realmente encerrar a sessão?"
    ;;
  lock)
    MESSAGE="Deseja bloquear a tela?"
    ;;
  suspend)
    MESSAGE="Deseja suspender o sistema?"
    ;;
  *)
    echo "Ação desconhecida: $ACTION"
    exit 1
    ;;
esac

ROFI_DIR="$HOME/.config/rofi/launchers/type-1"
ROFI_THEME="style-6"

CHOICE=$(echo -e "Não\nSim" | rofi -dmenu -mesg "$MESSAGE" -theme "${ROFI_DIR}/${ROFI_THEME}.rasi")

if [[ $CHOICE == "Sim" ]]; then
  case $ACTION in
    poweroff)
      systemctl poweroff
      ;;
    reboot)
      systemctl reboot
      ;;
    logout)
      hyprctl dispatch exit
      ;;
    lock)
      hyprlock
      ;;
    suspend)
      systemctl suspend
      ;;
  esac
fi
