ip addr flush dev eth0
ip addr add 10.83.16.42/29 dev eth0
ip link set eth0 up
ip route replace default via 10.83.16.41
