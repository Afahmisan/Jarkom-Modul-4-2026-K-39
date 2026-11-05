#!/bin/bash
# Konfigurasi Router Phantoma - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.86
    netmask 255.255.255.252
    gateway 10.83.16.85

auto eth1
iface eth1 inet static
    address 10.83.16.1
    netmask 255.255.255.224

auto eth2
iface eth2 inet static
    address 10.83.16.89
    netmask 255.255.255.252
NET

sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.86/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.16.1/27 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.89/30 dev eth2
ip link set eth2 up

ip route replace default via 10.83.16.85
ip route replace 10.83.15.0/26 via 10.83.16.90
