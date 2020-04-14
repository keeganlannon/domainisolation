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
       
    # Option 7
       # return to main menu
       # mainmenu;;
 
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
# Menu that will have 3 options : Connect to host , connect to internet , and return to main menu
  echo -e "\t****Set IPTables Policies****/n
  1. Allow connection to another host
  2. Allow a host to connect to the internet
  3. Return to Main Menu"
  read opt_policies
  case $opt_policies in 
  1) host ;; 
  2) internet ;; 
  3) mainmenu ;;
esac
done 
fi
}

# Option 1 , connection to another host 
host()
{
# Ask user for src IP 
read -p "What is the source IP address?: " src
# Ask user for dst IP 
read -p "What is the destination IP address?: " dst
# Ask user if they would like to set up a connection 
read -p "Would you like to connect these devices?: " connect
# if statement
# if connect = yes ssh into src ip run iptables rules with src and dst ip (INPUT and OUTPUT rules)
# OUTPUT rules will swap src and dst in iptables format 
# if connect = yes ssh into dst ip and run same rules
# src and dst will be in opposite postions as they were for src
# if connect = no return to policies menu 


}

# Option 2 , connect to internet 
internet()
{
# Ask user the host they would like to connect to the internet 
read -p "What is the IP address of the host you would like to connect to the internet?: " host
# ssh into the host variable 
# iptables rule (INPUT and OUTPUT) that would allow access to port 80/443 on that host 


}
 
 # Option 3
   # return to main menu
   # mainmenu;;
 
  }
