#!/bin/bash
# Konfigurasi Core Hub Router Wired - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 10.83.16.58
    netmask 255.255.255.252
    gateway 10.83.16.57

auto eth1
iface eth1 inet static
    address 10.83.16.33
    netmask 255.255.255.248

auto eth2
iface eth2 inet static
    address 10.83.16.61
    netmask 255.255.255.252

auto eth3
iface eth3 inet static
    address 10.83.16.65
    netmask 255.255.255.252
NET

sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.58/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.16.33/29 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.61/30 dev eth2
ip link set eth2 up

ip addr flush dev eth3
ip addr add 10.83.16.65/30 dev eth3
ip link set eth3 up

# Default route ke Cyberia (mencakup A7 10.83.14.0/25 & Internet NAT)
ip route replace default via 10.83.16.57
ip route replace 10.83.14.0/25 via 10.83.16.57

# Rute Cabang Barat (Switch2: Psyche, Copland, Schumann, Accela)
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
ip route replace 10.83.4.0/22 via 10.83.16.36
ip route replace 10.83.16.40/29 via 10.83.16.36
ip route replace 10.83.16.68/30 via 10.83.16.36

# Rute Cabang Timur (Navi: Supernet B3 10.83.12.0/23 + A10 10.83.15.64/26)
ip route replace 10.83.12.0/23 via 10.83.16.62
ip route replace 10.83.15.64/26 via 10.83.16.62

# Rute Backbone Selatan (Tachibana s.d. Shibuya dengan agregasi CIDR)
ip route replace 10.83.10.0/23 via 10.83.16.66
ip route replace 10.83.14.128/25 via 10.83.16.66
ip route replace 10.83.15.0/26 via 10.83.16.66
ip route replace 10.83.15.128/26 via 10.83.16.66
ip route replace 10.83.16.0/27 via 10.83.16.66
ip route replace 10.83.16.48/29 via 10.83.16.66
ip route replace 10.83.16.72/29 via 10.83.16.66
ip route replace 10.83.16.80/28 via 10.83.16.66
