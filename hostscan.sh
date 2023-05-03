#!/bin/bash

function ctrl_c(){
echo -e "\n\n[!] Saliendo...\n"
exit 1
}

tput civis
# Ctrl+C
trap ctrl_c INT

commons_ports=(21 22 23 25 53 80 110 111 135 139 143 443 445 993 995 1723 3306 3389 5900 8080)

for i in $(seq 1 254); do
timeout 1 bash -c "(ping -c 1 192.168.18.$i )" &>/dev/null && echo "[+] Host 192.168.18.$i - ACTIVE" &
done; wait
echo "[!] Escaneo icmp  finalizado"
for i in $(seq 1 254); do
for port in "${commons_ports[@]}"; do
  #echo "[+] Escaneando puerto $port en 192.168.18.$i"
  timeout 1 bash -c "echo '' > /dev/tcp/192.168.18.$i/$port" 2>/dev/null && echo "[+] Host 192.168.18.$i - $port - ACTIVE" &
done

done; wait

echo "[!] Escaneo tcp  finalizado"

tput cnorm