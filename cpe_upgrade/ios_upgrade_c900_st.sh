#!/usr/bin/expect -f

#set hostname "10.0.0.2"
set hostname [lindex $argv 0]
set ios "c900-universalk9-mz.SPA.159-3.M2.bin"
#set nmsip [lindex $argv 1]
set srvpassword [lindex $argv 2]
set passwd [lindex $argv 1]
set username admin
set timeout 2

#log_file -a /home/petropi1/joblog/ios_upgrade.log

send_user "\n"
send_user ">>>>>  Working on $hostname @ [exec date] <<<<<\n"
send_user "\n"
spawn ssh -o StrictHostKeyChecking=no $hostname -l $username
expect -re "Connection refused" {
spawn telnet $hostname }
expect "Password: "
send "$passwd\n"
expect "*>"
	    send "enable\n"
	    expect "*assword*"
	    send "$passwd\n"
	    expect "*#"
	    send "terminal length 0\r"
	    expect "*#"
	    send "show version\r"
	    expect "*#"





#expect "Username:"
#
#send "$user\n"

#expect "Password:"
#send "$passwd\n"

#expect ">$"

#send "enable\n"

#expect "Password:"

#send "$passwd\n"
#expect "#"
#
#send "!copy scp://support:$srvpassword@194.150.59.134/$ios flash:\n"
#expect "*"
#
#send "\r"
#expect "*#"
#
#send "!verify flash:$ios\r"
#expect "*#"
#
#send "conf t\r"
#expect "*(config)#$"
#
#
#send "!boot system flash:$ios\r"
#expect "*(config)#$"
#
#send "end\n"
#expect "*#"

#send "wr\r"
#expect "*#"

#send eof

