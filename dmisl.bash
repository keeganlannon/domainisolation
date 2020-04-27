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
    echo -e "You are currently in the main menu, please select one of the following\n"
    echo -e "1. Ipsec\n
     2. Iptables\n
     3. Iptables Policies\n"
    read opt_mainmenu
    case $opt_mainmenu in
     1) echo -e "=========================================================\n" 
                 ipsec
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
     2) echo -e "=========================================================\n"
                 iptables
        echo -e "========================================================="
                                  echo -e "Press Enter key to Continue..."
                                       read temp;;
     3) echo -e "=========================================================\n"  
                 policies
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
   opt_ipsec=1
   while [ $opt_ipsec != 7 ]
        do
         clear
    echo -e "You are currently in the Ipsec menu, please select one of the following\n
    echo -e "   1. Start Ipsec\n
     2. Stop Ipsec\n
     3. Restart Ipsec\n
     4. Create New Ipsec Connection\n
     5. Test Ipsec Connection\n
     6. Ipsec Status\n
     7. Return to Main Menu\n
    read opt_ipsec
    case $opt_ipsec in
 # Set up Submenu for ipsec with following options:
    # Start ipsec, stop ipsec, restart ipsec, setup new ipsec, test ipsec specific, test ipsec all
 
    1) echo -e "=========================================================\n" 
                 systemctl start ipsec
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    2) echo -e "=========================================================\n" 
                 systemctl stop ipsec
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    3) echo -e "=========================================================\n" 
                 systemctl restart ipsec
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    4) echo -e "=========================================================\n" 
                 # Create two new psks
                 lftpsk=$(dd if=dev/random count=16 bs=1 | xxd -s)
                 rghtpsk=$(dd if=dev/random count=16 bs=1 | xxd -s)
                 
                 # Add echo statement here
                 echo -e "The left host is one side of the ipsec tunnel and the right host is the other side of the tunnel. "
                 
                 # Have the user input the left source ip and store in variable
                 read -p "What is the left source IP address?: " lftsrc
                 
                 # Have the user input the left source ip subnet and store in variable
                 read -p "What is the left source IP address?: " lftsrcsub
                 
                 # Have the user input the left destintation ip and store in variable
                 read -p "What is the left destination IP address?: " lftdestsrc
                 
                 # Have the user input the left destintation ip subnet and store in variable
                 read -p "What is the left destination subnet address?: " lftdestsub
                 
                 # Have the user input the right source ip and store in variable
                 read -p "What is the right source IP address?: " rghtsrc
                 
                 # Have the user input the right destintation ip and store in variable
                 read -p "What is the right destination subnet address?: " rghtsrcsub
                 
                 # Have the user input the left destintation ip and store in variable
                 read -p "What is the right destination IP address?: " rghtdestsrc
                 
                 # Have the user input the left destintation ip subnet and store in variable
                 read -p "What is the right destination subnet address?: " rghtdestsub
                 
                 # Have the user input the server name
                 read -p "What is the server name for this connection?: " servname
                 
                 # Enter previous vairables into the ipsec.secrets file
                 ex /etc/ipsec.secrets << EOEX
                     :i
                     ### BEGIN $servname ###
                     
                     $lftsrc $lftdst: PSK "$lftpsk"
                     $rghtsrc $rghtdst: PSK "$rghtpsk"
                     
                     ### END $servname ###
                     .
                     :wq
                 EOEX
                     
                # Have the user name the new connection file and store in variable
                read -p "What is the name of the file for the new left connection?: " connflft
                
                # Have the user input connection name and store in variable
                read -p "What is the name of the new connection?: " connname
                
                # Set up the new left file
                ex /etc/ipsec.d/$connflft << EOEX
                    :i
                    config setup
                       protostack=netkey
                    enter connname
                      authby=secret
                      auto=start
                      left=$lftsrc
                      leftsubnet=$lftsrcsub/24
                      right=$lftdest
                      rightsubnet=$lftdestsub/24
                EOEX
                
                # Have the user name the new connection file and store in variable
                read -p "What is the name of the file for the new right connection?: " connflrght
                
                # Set up the new right file
                ex /etc/ipsec.d/$connflrght << EOEX
                    :i
                    config setup
                       protostack=netkey
                    enter connname
                      authby=secret
                      auto=start
                      left=$rghtsrc
                      leftsubnet=$rghtsrcsub/24
                      right=$rghtdest
                      rightsubnet=$rghtdestsub/24
                EOEX
                
                # Push config to new host
                    # Ask for left host that config should be pushed to
                    # Ask for right host that config should be pushed to
                    # push config to left host
                    # push config to right host
                    # reload ipsec (run ipsec auto -rereadsecrets command) on both hosts
                
                 # Start up the connection
                    ipsec setup start
                    ipsec auto -rereadsecrets
                    ipsec auto -add $connname
                    ipsec auto --up $connname
                ;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    5) echo -e "=========================================================\n" 
                 # Have the user input connection name
                 read -p "What is the name of the connection to test?: " connnametest
                 ipsec auto --up $connnametest
                 
                 ;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    6) echo -e "=========================================================\n" 
                 ipsec status all;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
    7) echo -e "=========================================================\n" 
                 mainmenu;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;; 
    *) echo -e "=========================================================\n" 
                echo -e "Wrong Option Selected!"
        sleep 2
        ipsec;;
        echo -e "\n=========================================================\n"
      echo -e "Press Enter key to Continue..."
      read temp;;
        esac
      done
 }


####################################################################################

# Iptables section of the menu
iptables()
  {
    opt_iptables=1
   while [ $opt_iptables != 7 ]
        do
         clear
    echo -e "You are currently in the Iptables menu, please select one of the following\n"
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
  2. Allow access to your webserver
  3. Return to Main Menu"
  read opt_policies
  case $opt_policies in 
  1) host ;; 
  2) web ;; 
  3) mainmenu ;;
esac

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
if [ $connect == 'yes' ]
 then
    ssh root@$src "iptables -A INPUT -s $dst -d $src -j ACCEPT && iptables -A OUTPUT -s $src -d $dst -j ACCEPT"
    ssh root@$dst "iptables -A INPUT -s $src -d $dst -j ACCEPT && iptables -A OUTPUT -s $dst -d $src -j ACCEPT"
# else return to policies menu
else 
  policies
fi

}

# Option 2 , connect to internet 
web()
{
# Ask user the IP address of their web server  
read -p "What is the IP address of your web server?: " webserver
# ssh into the host variable 
# iptables rule (INPUT and OUTPUT) that would allow access to port 80/443 on that host 
read -p "Would you like to allow access to your web server? " access
if [ $access == 'yes' ]
 then
     ssh root@$webserver "iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT && iptables -A OUTPUT -p tcp -m multiport --sports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT"
 else
   policies 
 fi   


}
 
 # Option 3
   # return to main menu
   mainmenu
 
  }
