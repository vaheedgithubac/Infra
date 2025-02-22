#! /bin/bash
echo " start of the nat user_data.sh script"
sudo yum install iptables-services -y
sudo systemctl enable iptables
sudo systemctl start iptables
sudo sysctl -w net.ipv4.ip_forward=1
sudo /sbin/iptables -t nat -A POSTROUTING -o enX0 -j MASQUERADE
# sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo /sbin/iptables -F FORWARD
echo " reached end of the nat user_data.sh script"
