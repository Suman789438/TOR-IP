#!/bin/bash
#dont copy my code 

# ========== COLORS ==========
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
W='\033[1;37m'
NC='\033[0m'

# ========== AUTO FLAG ==========
country_flag() {
  CC=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  FLAG=""
  for ((i=0; i<${#CC}; i++)); do
    CHAR=${CC:$i:1}
    UNICODE=$(printf '%d' "'$CHAR")
    FLAG+=$(printf "\\U%08X" $((UNICODE + 127397)))
  done
  echo "$FLAG"
}

# ========== BANNER ==========
banner() {
clear
echo -e "${C}"
echo " ████████╗ ██████╗ ██████╗     ██╗██████╗ "
echo " ╚══██╔══╝██╔═══██╗██╔══██╗    ██║██╔══██╗"
echo "    ██║   ██║   ██║██████╔╝    ██║██████╔╝"
echo "    ██║   ██║   ██║██╔══██╗    ██║██╔═══╝ "
echo "    ██║   ╚██████╔╝██║  ██║    ██║██║     "
echo "    ╚═╝    ╚═════╝ ╚═╝  ╚═╝    ╚═╝╚═╝     "
echo -e "${NC}"
echo -e "${Y}Author  : THE SILENT HACKER RAJ🚭l${NC}"
echo -e "${Y}YouTube : https://www.youtube.com/@CYBER_SHR${B}"
echo -e "${Y}Tool neme  : Termux Tor IP Changer ☠️${C}"
echo -e "${Y} WhatsApp group link : https://chat.whatsapp.com/CW5TVcsSKDi62yMZdlDGmk${G}"
echo -e "${Y}=========================================${W}"
}

# ========== ☠️ TOR START ☠️ ==========
start_tor() {
pkill tor 2>/dev/null
tor > /dev/null 2>&1 &
sleep 12
}

# ========== IP INFO ==========
show_ip() {
JSON=$(curl -s --socks5 127.0.0.1:9050 https://ipinfo.io/json)

IP=$(echo "$JSON" | grep -oP '"ip":\s*"\K[^"]+')
CC=$(echo "$JSON" | grep -oP '"country":\s*"\K[^"]+')
CN=$(echo "$JSON" | grep -oP '"country":\s*"\K[^"]+' | sed 's/.*/&/')
CITY=$(echo "$JSON" | grep -oP '"city":\s*"\K[^"]+')

FLAG=$(country_flag "$CC")

echo -e "${B}🌐 IP       : ${G}$IP${NC}"
echo -e "${C}🌍 Country  : ${Y}$FLAG  $CC${NC}"
echo -e "${P}🏙 City     : ${W}$CITY${NC}"
}

# ========== AUTO CHANGE ==========
auto_change() {
read -p "Enter interval in seconds (default 10): " T
T=${T:-10}

echo -e "${R}[!] Press CTRL + C to stop${NC}"
while true
do
  pkill -HUP tor
  sleep 5
  banner
  show_ip
  echo -e "${C}⏱ Auto changing every $T seconds${NC}"
  sleep "$T"
done
}

# ========== MENU ==========
menu() {
while true
do
banner
echo -e "${C}[1] Start Auto IP Change${NC}"
echo -e "${C}[2] Show Current IP Info${NC}"
echo -e "${C}[3] Restart Tor${NC}"
echo -e "${C}[0] Exit${NC}"
echo
read -p "Select Option: " opt

case $opt in
1)
start_tor
auto_change
;;
2)
start_tor
banner
show_ip
read -p "Press Enter..."
;;
3)
start_tor
;;
0)
exit
;;
*)
echo -e "${R}Invalid option${NC}"
sleep 1
;;
esac
done
}

menu
