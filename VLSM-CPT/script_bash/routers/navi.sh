sysctl -w net.ipv4.ip_forward=1

ip addr flush dev eth0
ip addr add 10.83.16.62/30 dev eth0
ip link set eth0 up

ip addr flush dev eth1
ip addr add 10.83.12.1/24 dev eth1
ip link set eth1 up

ip addr flush dev eth2
ip addr add 10.83.15.65/26 dev eth2
ip link set eth2 up

ip addr flush dev eth3
ip addr add 10.83.13.1/24 dev eth3
ip link set eth3 up

ip route replace default via 10.83.16.61
