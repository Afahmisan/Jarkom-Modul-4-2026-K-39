#!/bin/bash
# Konfigurasi Router Shibuya - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.90
    netmask 255.255.255.252
    gateway 10.83.16.89

auto eth1
iface eth1 inet static
    address 10.83.15.1
    netmask 255.255.255.192
NET

sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.90/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.15.1/26 dev eth1
ip link set eth1 up

ip route replace default via 10.83.16.89
