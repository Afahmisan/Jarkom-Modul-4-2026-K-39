sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.36/29 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.16.41/29 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.16.69/30 dev eth2
ip link set eth2 up

ip route replace 10.83.4.0/22 via 10.83.16.70
ip route replace 10.83.0.0/22 via 10.83.16.34
ip route replace 10.83.8.0/23 via 10.83.16.35
ip route replace 10.83.15.192/26 via 10.83.16.35
ip route replace default via 10.83.16.33
