#iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.40.0.0/21

ipEth0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"
iptables -t nat -A POSTROUTING -s 10.40.0.0/21 -o eth0 -j SNAT --to-source "$ip$

route add -net 10.40.7.128 netmask 255.255.255.248 gw 10.40.7.146
route add -net 10.40.0.0 netmask 255.255.252.0 gw 10.40.7.146
route add -net 10.40.7.0 netmask 255.255.255.128 gw 10.40.7.146

route add -net 10.40.6.0 netmask 255.255.255.0 gw 10.40.7.150
route add -net 10.40.4.0 netmask 255.255.254.0 gw 10.40.7.150
route add -net 10.40.7.136 netmask 255.255.255.248 gw 10.40.7.150

