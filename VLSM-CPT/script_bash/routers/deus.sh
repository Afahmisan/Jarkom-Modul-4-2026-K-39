sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.74/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.14.129/25 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.77/30 dev eth2
ip link set eth2 up

ip route replace 10.83.15.0/26 via 10.83.16.78
ip route replace 10.83.15.128/26 via 10.83.16.78
ip route replace 10.83.16.0/27 via 10.83.16.78
ip route replace 10.83.16.48/29 via 10.83.16.78
ip route replace 10.83.16.80/28 via 10.83.16.78
ip route replace default via 10.83.16.73
