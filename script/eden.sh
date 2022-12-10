echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get install bind9 -y

echo "
options {
        directory \"/var/cache/bind\";
        forwarders {
                192.168.122.1;
        };
        allow-query{ any; };
        auth-nxdomain no;
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options

iptables -A INPUT -p ICMP -m connlimit --connlimit-above 2 --connlimit-mask 0 -$

service bind9 restart