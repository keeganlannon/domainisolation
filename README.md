# Linux Domain Isolation Project 
The Linux Domain Isolation Project is designed to create an isolated domain within a Linux environment using IPsec and iptables. 

This project was inspired by the the fact that Microsoft does something similar to this, and with all the Linux used in the world of IT, this project seemed necessary.

The Linux Domain Isolation project uses a script that is able to isolate part of a network from the rest of the network. This allows for an added layer of security for critical machines on a network. The script, dmisl, will be able to run on one domain controller, and control network connections. The script allows the user to add additonal IPsec connections for network devices, check IPsec statuses on network devices, set specific iptables policies on network devices, and check iptables stasuses on network devices. 

The iptables scripts are a list of iptables rules that would created an isolated domain for devices already connected with an IPsec tunnel. 
