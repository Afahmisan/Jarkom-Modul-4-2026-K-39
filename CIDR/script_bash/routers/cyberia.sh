#!/bin/bash
# Konfigurasi Router Cyberia (Gateway NAT & LAN A7) - Kelompok K-39 (CIDR)
cat << 'NET' > /etc/network/interfaces
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.83.14.1
    netmask 255.255.255.128

auto eth2
iface eth2 inet static
    address 10.83.16.57
    netmask 255.255.255.252
NET

ip link set eth0 up
/gns3/bin/udhcpc -i eth0 -s /gns3/etc/udhcpc.script 2>/dev/null || dhclient eth0 2>/dev/null || (ip addr add 192.168.122.2/24 dev eth0 && ip route replace default via 192.168.122.1)

ip addr flush dev eth1
ip addr add 10.83.14.1/25 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.57/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -F
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Supernetting CIDR: 1 baris rute mencakup seluruh subnet di bawah Wired (10.83.0.0/19)
ip route replace 10.83.0.0/19 via 10.83.16.58
echo "nameserver 8.8.8.8" > /etc/resolv.conf
