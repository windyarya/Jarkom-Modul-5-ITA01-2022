echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get install isc-dhcp-relay -y

echo '
SERVERS="10.40.7.131"
INTERFACES="eth0 eth1 eth2 eth3"
OPTIONS=""
' > /etc/default/isc-dhcp-relay
service isc-dhcp-relay restart