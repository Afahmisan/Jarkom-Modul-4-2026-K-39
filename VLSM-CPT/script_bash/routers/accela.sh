sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.70/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.4.1/22 dev eth1
ip link set eth1 up

ip route replace default via 10.83.16.69
