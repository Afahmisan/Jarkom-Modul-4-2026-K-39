#!/bin/bash
# Konfigurasi Node Host Specter (Subnet A8) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.14.131
    netmask 255.255.255.128
    gateway 10.83.14.129
NET

ip addr flush dev eth0
ip addr add 10.83.14.131/25 dev eth0
ip link set eth0 up
ip route replace default via 10.83.14.129
echo "nameserver 8.8.8.8" > /etc/resolv.conf
