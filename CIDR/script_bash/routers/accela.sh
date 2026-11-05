#!/bin/bash
# Konfigurasi Router Accela - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.70
    netmask 255.255.255.252
    gateway 10.83.16.69

auto eth1
iface eth1 inet static
    address 10.83.4.1
    netmask 255.255.252.0
NET

sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.70/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.4.1/22 dev eth1
ip link set eth1 up

ip route replace default via 10.83.16.69
