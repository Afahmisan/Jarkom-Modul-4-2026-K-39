#!/bin/bash
# Konfigurasi Node Host Omnipresence (Subnet A2) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.4.2
    netmask 255.255.252.0
    gateway 10.83.4.1
NET

ip addr flush dev eth0
ip addr add 10.83.4.2/22 dev eth0
ip link set eth0 up
ip route replace default via 10.83.4.1
echo "nameserver 8.8.8.8" > /etc/resolv.conf
