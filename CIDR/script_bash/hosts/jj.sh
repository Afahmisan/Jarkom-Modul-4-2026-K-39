#!/bin/bash
# Konfigurasi Node Host Jj (Subnet A7) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.14.2
    netmask 255.255.255.128
    gateway 10.83.14.1
NET

ip addr flush dev eth0
ip addr add 10.83.14.2/25 dev eth0
ip link set eth0 up
ip route replace default via 10.83.14.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
