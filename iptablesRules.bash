#!/bin/bash 

# Variables for system IP addresses 
centos01=10.0.5.21
centos02=10.0.5.6
centos03=10.0.5.20

# Flush current rules 
iptables -F

# Set IPtables Policy to DROP everything 
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP 

# Allow IPsec communication between centos01 and centos03 
iptables -A INPUT -s $centos03 -d $centos01 -p udp --sport 4500 --dport 4500 -j ACCEPT 
iptables -A INPUT -s $centos03 -d $centos01 -p udp --sport 500 --dport 500 -j ACCEPT
iptables -A INPUT -s $centos03 -d $centos01 -p udp --sport 1701 --dport 1701 -j ACCEPT 
iptables -A INPUT -s $centos03 -d $centos01 -p esp -j ACCEPT
iptables -A INPUT -s $centos03 -d $centos01 -p ah -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p udp --sport 4500 --dport 4500 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p udp --sport 500 --dport 500 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p udp --sport 1701 --dport 1701 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p esp -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p ah -j ACCEPT 

# Allow IPsec communication between centos01 and centos02
iptables -A INPUT -s $centos02 -d $centos01 -p udp --sport 4500 --dport 4500 -j ACCEPT
iptables -A INPUT -s $centos02 -d $centos01 -p udp --sport 500 --dport 500 -j ACCEPT
iptables -A INPUT -s $centos02 -d $centos01 -p udp --sport 1701 --dport 1701 -j ACCEPT
iptables -A INPUT -s $centos02 -d $centos01 -p esp -j ACCEPT
iptables -A INPUT -s $centos02 -d $centos01 -p ah -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p udp --sport 4500 --dport 4500 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p udp --sport 500 --dport 500 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p udp --sport 1701 --dport 1701 -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p esp -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p ah -j ACCEPT

# Allow centos01 and centos03 to ping each other 
iptables -A INPUT -s $centos03 -d $centos01 -p icmp --icmp-type echo-reply -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT 
iptables -A INPUT -s $centos03 -d $centos01 -p icmp --icmp-type echo-request -m state --state NEW,ESTABLISHED,RELATED
iptables -A OUTPUT -s $centos01 -d $centos03 -p icmp --icmp-type echo-request -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos03 -p icmp --icmp-type echo-reply -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT 

# Allow centos01 and centos02 to ping each other 
iptables -A INPUT -s $centos02 -d $centos01 -p icmp --icmp-type echo-reply -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -s $centos02 -d $centos01 -p icmp --icmp-type echo-request -m state --state NEW,ESTABLISHED,RELATED
iptables -A OUTPUT -s $centos01 -d $centos02 -p icmp --icmp-type echo-request -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -s $centos01 -d $centos02 -p icmp --icmp-type echo-reply -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT 
