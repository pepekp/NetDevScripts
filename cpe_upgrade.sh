#!/bin/bash

# Author:       Peter K. Petrov
#
# Description:  Upgrade of IOS and JunOS to the current certified software version.
#
# GTT 2021/10
#

ch="your choice:"
select ITEM in "Cisco IOS 921" "Cisco IOS 921 MPLS" "Cisco 11xx" "Cisco 11xx MPLS" "Cisco 9300" "Cisco 9300 MPLS" "Juniper SRX210" "Quit"
do
  # Cisco 921 
  if [[ $REPLY -eq 1 ]]; then
    echo "Target Device IP: "
    read -e devip
    IFS=' '
    currversion='"CW_VERSION$15.9(3)M4$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}
    if [[ $currversion == $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "#########################################################"
      sleep 2
      exit 0
    elif [[ $currversion != $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "#########################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n"
      echo ""
      echo "#########################################################"
      read -e reply1
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server password:
        read -s srvpassword
        echo ""
        serverip="169.0.0.254"
        echo ""
        /usr/bin/expect ./pushers/ios_upgrade_c900.sh $devip $password $srvpassword $serverip
       else
        echo "Something went wrong..."
      fi
    fi
  # Cisco 921 MPLS
  elif [[ $REPLY -eq 2 ]]; then
    echo "Target Device IP:"
    read -e devip
    echo ""
    cpepwdget $devip
    IFS=' '
    currversion='"CW_VERSION$15.9(3)M4$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}

    if [[ $currversion == $jver ]]; then
      echo "##############################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "##############################################################"
      sleep 1
      exit 0
    elif [[ $currversion != $jver ]]; then
      echo "##############################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo ""
      echo "###############################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n"
      echo ""
      echo "###############################################################"
      read -e reply1
      echo ""
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server 212.23.36.12 password:
        read -s srvpassword
        echo ""
        echo $devip $password $srvpassword
        echo ""
        echo ""
        /usr/bin/expect ./pushers/mpls_ios_upgrade_c900.sh $devip $password $srvpassword
       else
        echo "Something went wrong..."
       fi
    fi
# Cisco c1100 DIA
  elif [[ $REPLY -eq 3 ]]; then
    echo "Target Device IP:"
    read -e devip
    IFS=' '
    currversion='"CW_VERSION$16.12.6$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}
    if [[ $currversion == $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "#########################################################"
      sleep 2
      exit 0
    elif [[ $currversion != $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "#########################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n     "
      echo ""
      echo "#########################################################"
      read -e reply1
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server password:
        read -s srvpassword
        echo ""
        #echo $devip $password $srvpassword
        echo ""
        serverip="169.0.0.254"
        /usr/bin/expect ./pushers/ios_upgrade_c11xx_mpls.sh $devip $password $srvpassword $serverip
       else
        echo "Something went wrong..."
      fi
    fi
# Cisco c1100 MPLS
  elif [[ $REPLY -eq 4 ]]; then
    echo "Target Device IP:"
    read -e devip
    IFS=' '
    currversion='"CW_VERSION$16.12.6$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}
    if [[ $currversion == $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "#########################################################"
      sleep 2
      exit 0
    elif [[ $currversion != $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "#########################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n"
      echo ""
      echo "#########################################################"
      read -e reply1
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server 169.0.0.254 password:
        read -s srvpassword
        echo ""
        serverip="169.0.0.254"
        #echo $devip $password $srvpassword
        echo ""
        /usr/bin/expect ./pushers/ios_upgrade_c11xx_mpls.sh $devip $password $srvpassword $serverip
       else
        echo "Something went wrong..."
      fi
    fi

################################
# Cisco c9300 DIA
  elif [[ $REPLY -eq 5 ]]; then
    echo "Target Device IP:"
    read -e devip
    IFS=' '
    currversion='"CW_VERSION$16.12.6$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}
    if [[ $currversion == $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "#########################################################"
      sleep 2
      exit 0
    elif [[ $currversion != $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "#########################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n"
      echo ""
      echo "#########################################################"
      read -e reply1
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server 213.39.35.41 password:
        read -s srvpassword
        echo ""
        #echo $devip $password $srvpassword
        echo ""
        serverip="213.39.35.41"
        /usr/bin/expect ./pushers/ios_upgrade_c9300.sh $devip $password $srvpassword $serverip
       else
        echo "Something went wrong..."
      fi
    fi

################################
# Cisco c9300 MPLS
  elif [[ $REPLY -eq 6 ]]; then
    echo "Target Device IP:"
    read -e devip
    IFS=' '
    currversion='"CW_VERSION$16.12.6$"'
    getversion=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.4.1.9.9.25.1.1.1.2.5);
    read -a strarr <<< "$getversion"
    getversionsplit=${strarr[3]}
    if [[ $currversion == $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
      echo ""
      echo "#########################################################"
      sleep 2
      exit 0
    elif [[ $currversion != $getversionsplit ]]; then
      echo "#########################################################"
      echo ""
      echo "        Current IOS version is: $getversionsplit"
      echo "        Certified IOS version is: $currversion"
      echo ""
      echo "#########################################################"
      echo ""
      echo "   Do you want to install certified IOS version? y/n"
      echo ""
      echo "#########################################################"
      read -e reply1
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server 169.0.0.254 password:
        read -s srvpassword
        echo ""
        #echo $devip $password $srvpassword
        echo ""
        serverip="169.0.0.254"
        /usr/bin/expect ./pushers/ios_upgrade_c9300_mpls.sh $devip $password $srvpassword $serverip
       else
        echo "Something went wrong..."
      fi
    fi

# Juniper SRX 300

  elif [[ $REPLY -eq 7 ]]; then
    echo "Target Device IP:"
    read -e devip
    IFS=' '
    currversion="19.4R3-S5"
    sysid=$(/usr/bin/snmpget -v 2c -c labComm $devip 1.3.6.1.2.1.1.1.0);
    read -r -a array <<<"$sysid"
    jver=${array[11]}
    if [[ $currversion == $jver ]]; then
      echo "##############################################################"
      echo ""
      echo "        Current Junos version is: $jver"
      echo "        Certified Junos version is: $currversion"
      echo ""
      echo "        No version change required. Exiting...."
       echo ""
      echo "##############################################################"
      sleep 1
      exit 0
    elif [[ $currversion != $jver ]]; then
     echo "###############################################################"
      echo ""
      echo "        Current Junos version is: $jver"
      echo "        Certified Junos version is: $currversion"
      echo ""
      echo ""
      echo "##############################################################"
      echo ""
      echo "   Do you want to install certified Junos version? y/n"
      echo ""
      echo "##############################################################"
      read -e reply1
      echo ""
      if [[ $reply1 =~ ^[Nn]$ ]]; then
        echo "Exit..."
        sleep 1
        exit 0
      elif [[ $reply1 =~ ^[Yy]$ ]]; then
        echo -n Enter device password:
        read -s password
        echo ""
        echo -n Enter server password:
        read -s srvpassword
        echo ""
        serverip="169.0.0.254"
        echo $devip $password $srvpassword
       #/usr/bin/expect /home/petropi1/pushers/ios_upgrade_j300.sh $devip $password $srvpassword $serverip
      else
        echo "Something went wrong..."
      fi
    fi
  elif [[ $REPLY -eq 8 ]]; then
    sleep 1
    exit
  else
    echo="Exit..."
    exit 0
  fi
done
