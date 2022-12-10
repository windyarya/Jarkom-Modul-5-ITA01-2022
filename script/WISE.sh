echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get install isc-dhcp-server -y

echo "
INTERFACES=\"eth0\"
" > /etc/default/isc-dhcp-server

echo "
ddns-update-style none;
option domain-name \"example.org\";
option domain-name-servers ns1.example.org, ns2.example.org;
default-lease-time 600;
max-lease-time 7200;
log-facility local7;

#Subnet A2
subnet 10.40.0.0 netmask 255.255.252.0 {
        range 10.40.0.2 10.40.3.254;
        option routers 10.40.0.1;
        option broadcast-address 10.40.3.255;
        option domain-name-servers 10.40.7.130;
        default-lease-time 360;
        max-lease-time 7200;
}

#Subnet A7
subnet 10.40.4.0 netmask 255.255.254.0 {
        range 10.40.4.2 10.40.5.254;
        option routers 10.40.4.1;
        option broadcast-address 10.40.5.255;
        option domain-name-servers 10.40.7.130;
        default-lease-time 360;
        max-lease-time 7200;
}

#Subnet A6
subnet 10.40.6.0 netmask 255.255.255.0 {
        range 10.40.6.2 10.40.6.254;
        option routers 10.40.6.1;
        option broadcast-address 10.40.6.255;
        option domain-name-servers 10.40.7.130;
        default-lease-time 360;
        max-lease-time 7200;
}

#Subnet A3
subnet 10.40.7.0 netmask 255.255.255.128 {
        range 10.40.7.2 10.40.7.126;
        option routers 10.40.7.1;
        option broadcast-address 10.40.7.127;
        option domain-name-servers 10.40.7.130;
        default-lease-time 360;
        max-lease-time 7200;
}

#Subnet A1
subnet 10.40.7.128 netmask 255.255.255.248 {}

#Subnet A8
subnet 10.40.7.136 netmask 255.255.255.248 {}

#Subnet A4
subnet 10.40.7.144 netmask 255.255.255.252 {}

#Subnet A5
subnet 10.40.7.148 netmask 255.255.255.252 {}
" > /etc/dhcp/dhcpd.conf

iptables -A INPUT -p ICMP -m connlimit --connlimit-above 2 --conlimit-mask 0 -j$

service isc-dhcp-server restart