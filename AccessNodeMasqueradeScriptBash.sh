#! /bin/bash
#This scrip will allow forwarding of all IP TCP packets btn WanIF
#and LANIF when run

#The IPTABLES command is volatile (does not persist reboot)
#the kernel IP forwarding enablement is persistant, possibly 
#all kernal IP forwarding is set to 0 by default which assumes
#typical install is application/service server or desktop and not
#an infrastructure box

IPTABLES=/sbin/iptables

#use ip addr command so see your network interfaces and pick two to connect
#connection will forward all traffic between the two, and Masquerade
#Masquerade attaches its own IP after routing (postroute) to incoming on each
#network interface so destination knows what hope to insert for reply
#(this machine behaves as router)

WANIF='tun0'
LANIF='eth0'

echo "Checking to see if ip4 forwarding is on..."
sleep 2.5
echo " "

#check to see is ip4 forwarding is on in /etc/sysctl.conf
if grep -q 'net.ipv4.ip_forward=1' /etc/sysctl.conf; then
	echo 'PASS! ip4 net.ipv4.ip_forwarding=1 in /etc/sysctl.conf'
else
echo "!!!! FAIL !!!!!"
sleep 1.5
echo "IP forwarding might be off (0), pls set net.ipv4.ip_forward=1"
sleep .25
echo "..........try: sudo nano /etc/sysctl.conf"
sleep 10; exit
fi

sleep .3
echo "   ^^^^ !!!! ^^^^^  !!!!! ^^^^^  "
sleep .35
echo "        !!!! ^^^^^  !!!!!   "
sleep .25
echo "   ^^^^ !!!! ^^^^^  !!!!! ^^^^^  "
sleep .15
echo " "
sleep 5

# flush rules and delete chains
echo 'Flushing rules and deleting existing chains...'
sudo $IPTABLES -F
sudo $IPTABLES -X

sleep .5;echo "*";sleep .35;echo "**";sleep .25;echo "***";sleep .15;echo "****";
echo " "
sleep 1

# enable masquerading to allow LAN internet access
echo 'Enabling IP Masquerading and other rules...'
sudo $IPTABLES -t nat -A POSTROUTING -o $LANIF -j MASQUERADE
sudo $IPTABLES -A FORWARD -i $LANIF -o $WANIF -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo $IPTABLES -A FORWARD -i $WANIF -o $LANIF -j ACCEPT

sudo $IPTABLES -t nat -A POSTROUTING -o $WANIF -j MASQUERADE
sudo $IPTABLES -A FORWARD -i $WANIF -o $LANIF -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo $IPTABLES -A FORWARD -i $LANIF -o $WANIF -j ACCEPT

sleep 1.5;echo "*";sleep .35;echo "**";sleep .25;echo "***";sleep .15;echo "****";sleep .05;echo "*****"
sleep .05
echo 'Done!'
sleep 6.9420
exit

$SHELL
