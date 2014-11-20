#!/bin/bash
aptitude install hostapd udhcpd -y

cat << EOF >/etc/udhcpd.conf
start 192.168.42.2 # This is the range of IPs that the hostspot will give to client devices.
end 192.168.42.20
interface wlan0 # The device uDHCP listens on.
remaining yes
opt dns 8.8.8.8 8.8.4.4 # The DNS servers client devices will use.
opt subnet 255.255.255.0
opt router 192.168.42.1 # The Pi's IP address on wlan0 which we will set up shortly.
opt lease 864000 # 10 day DHCP lease time in seconds
EOF

echo 'DHCPD_OPTS="-S"' > /etc/default/udhcpd

ifconfig wlan0 192.168.42.1

cat << EOF >/etc/hostapd/hostapd.conf
interface=wlan0
ssid=FreeWifi
hw_mode=g
channel=6
auth_algs=1
wmm_enabled=0

EOF

cat << EOF >/etc/network/interfaces
auto lo

iface lo inet loopback
iface eth0 inet dhcp

#allow-hotplug wlan0
#wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
#iface default inet dhcp

iface wlan0 inet static
  address 192.168.42.1
  netmask 255.255.255.0

up iptables-restore < /etc/iptables.ipv4.nat
EOF

echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' > /etc/default/hostapd

sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

sh -c "iptables-save > /etc/iptables.ipv4.nat"

service hostapd start
service udhcpd start

update-rc.d hostapd enable
update-rc.d udhcpd enable
