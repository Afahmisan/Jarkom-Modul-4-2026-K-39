#!/bin/bash
# Konfigurasi Node Host Eiri (Subnet A16) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.50
    netmask 255.255.255.248
    gateway 10.83.16.49
NET

ip addr flush dev eth0
ip addr add 10.83.16.50/29 dev eth0
ip link set eth0 up
ip route replace default via 10.83.16.49
echo "nameserver 8.8.8.8" > /etc/resolv.conf
