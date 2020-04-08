#!/bin/bash

# This is a script that contains a menu with functions that work based on the choices made in the menu

echo -e "==============Welcome=============="

# Main Menu
mainmenu()
 {
    opt_mainmenu=1
   while [ $opt_mainmenu != 3 ]
        do
         clear
    echo -e "You are currently in the main menu, please select one of the following\n
    echo -e "   1. Ipsec\n
     2. Iptables\n
     3. Iptables Policies\n
    read opt_mainmenu
    case $opt_mainmenu in
     1) echo -e "=========================================================\n" 
                 ipsec;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
     2) echo -e "=========================================================\n"
                 iptables;; 
        echo -e "========================================================="
                                  echo -e "Press Enter key to Continue..."
                                       read temp;;
     3) echo -e "=========================================================\n"  
                 policies;; 
        echo -e "=========================================================\n"
                                   echo -e "Press Enter key to Continue..."
                                         read temp;;
     *) echo -e "Wrong Option Selected!"
        sleep 2
        mainmenu;;
    esac
   done
 }

####################################################################################
ipsec()
 {
 
 # Set up Submenu for ipsec with following options:
    # Start ipsec, stop ipsec, restart ipsec, setup new ipsec, test ipsec specific, test ipsec all
 
    # Option 1
       # Systemctl start ipsec

    # Option 2
       # Systemctl stop ipsec

    # Option 3
       # Systemctl restart ipsec

    # Option 4
       # Create two new psks
       # store them in the pre-labelled variables (left, right)
       # Have the user input the left source ip and store in variable
       # Have the user input the left destintation ip and store in variable
       # Have the user input the right source ip and store in variable
       # Have the user input the right destintation ip and store in variable
       # Vim /etc/ipsec.secrets
            # enter left source left destination: "left psk"
            # enter right source right destination: "right psk"
       # Have the user name the new connection file and store in variable
       # Have the user input connection name and store in variable
       # Have the user input type and store in variable
       # Have the user input encryption (ex: aes256-sha2_256!) and store in variable
       # Vim /etc/ipsec.d/connection_file_variable
            # config setup
                # protostack=netkey
            # enter connection name
                # authby=psk
                # auto=route
                # keyexchnage=ike
                # left source/24
                # left source subnet/24
                # left destination/24
                # left destination subnet/24
                # type
                # esp
       # Ipsec setup start
       # ipsec auto -rereadsecrets
       # ipsec auto -add [connection name]
       # ipsec auto --up [connection name]

    # Option 5
       # Have the user input connection name
       # ipsec auto --up [connection name]
       
    # Option 6
       # ipsec status all
 
 }


####################################################################################

# Iptables section of the menu
iptables()
  {
    opt_iptables=1
   while [ $opt_iptables != 7 ]
        do
         clear
    echo -e "You are currently in the Iptables menu, please select one of the following\n
    echo -e "   1. Save the iptables\n
     2. Status of Iptables\n
     3. Start iptables Services\n
     4. Stop iptables Services\n
     5. Restart iptable Services\n
     6. Flush iptables (==Use Carefully_it will remove all the rules from iptables==)\n
     7. Go back to Main Menu"
    read opt_iptables
    case $opt_iptables in
     1) echo -e "=========================================================\n" 
                 /etc/init.d/iptables save 
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
     2) echo -e "=========================================================\n"
                 /etc/init.d/iptables status 
        echo -e "========================================================="
                                  echo -e "Press Enter key to Continue..."
                                       read temp;;
     3) echo -e "=========================================================\n"  
                 /etc/init.d/iptables start 
        echo -e "=========================================================\n"
                                   echo -e "Press Enter key to Continue..."
                                         read temp;;

     4) echo -e "=========================================================\n"
                 /etc/init.d/iptables stop
        echo -e "=========================================================\n"
                                  echo -e "Press Enter key to Continue..."
                                       read temp;;

               5) echo -e "=========================================================\n"
                        /etc/init.d/iptables restart 
        echo -e "=========================================================\n"
                                  echo -e "Press Enter key to Continue..."
                                       read temp;;
     6) iptables -F 
     echo -e "========================================================="
     echo -e "All the Rules from the Iptables are Flushed!!!"
     echo -e "=========================================================\n"
                                  echo -e "Press Enter key to Continue..."
                                   read temp;;
     7) mainmenu;;
     *) echo -e "Wrong Option Selected!"
        sleep 2
        iptables;;
    esac
   done
  }
  
####################################################################################
policies()
  {
 # This function will be used to set new iptables policies
 
 # Menu that will have 2 options 
 # Set Connection to another host, or set up internet connectivity
 # Ask user to select one of the options 
 
 # Option 1 
 # Connection to another host 
 
   # Ask user for the src IP of the connection 
   # Set this answer to be a parameter 
 
   # Ask user for the dst IP of the connection 
   # Set this answer as another parameter
 
   # Ask the user if they would like to set up a connection 
   # If yes create an iptables rule that adds a rule with the parameters of the src ip and dst ip
 
 # Option 2
 # Create rule for internet connectivity 
 
   # Ask user for IP address of the host 
   # Set this answer as a parameter 
 
   # Ask user if this host can access the internet 
   # If yes create an iptables rule that allows the host to communicate with the internet
 
 
  }
