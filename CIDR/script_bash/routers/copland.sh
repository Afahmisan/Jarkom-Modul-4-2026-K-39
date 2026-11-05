#!/bin/bash
# Konfigurasi Router Copland - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.35
    netmask 255.255.255.248
    gateway 10.83.16.33

auto eth1
iface eth1 inet static
    address 10.83.15.193
    netmask 255.255.255.192

auto eth2
iface eth2 inet static
    address 10.83.8.1
    netmask 255.255.254.0
NET

sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.35/29 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.15.193/26 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.8.1/23 dev eth2
ip link set eth2 up

ip route replace default via 10.83.16.33
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36
