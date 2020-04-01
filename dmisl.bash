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
    echo -e "\nChoose the Option Bellow!\n
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
    esac
   done
 }

####################################################################################
ipsec()
 {
 
 }


####################################################################################

# Iptables section of the menu
iptables()
  {
    opt_iptables=1
   while [ $opt_iptables != 7 ]
        do
         clear
    echo -e "\nChoose the Option Bellow!!!\n
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
     7) main;;
     *) echo -e "Wrong Option Selected!"
    esac
   done
  }
  
####################################################################################
policies()
  {
  
  }
