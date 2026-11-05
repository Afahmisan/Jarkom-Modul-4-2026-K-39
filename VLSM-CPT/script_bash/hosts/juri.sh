ip addr flush dev eth0
ip addr add 10.83.15.194/26 dev eth0
ip link set eth0 up
ip route replace default via 10.83.15.193
