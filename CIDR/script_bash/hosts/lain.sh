#!/bin/bash
# Konfigurasi Node Host Lain (Subnet A9) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.15.2
    netmask 255.255.255.192
    gateway 10.83.15.1
NET

ip addr flush dev eth0
ip addr add 10.83.15.2/26 dev eth0
ip link set eth0 up
ip route replace default via 10.83.15.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
