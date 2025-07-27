#!/usr/bin/expect -f


set user admin
set hostname [lindex $argv 0]
set ios "c900-universalk9-mz.SPA.159-3.M4.bin"
set serverip [lindex $argv 3]
set srvpassword [lindex $argv 2]
set passwd [lindex $argv 1]

set timeout 2


log_file -a /home/petropi1/joblog/ios_upgrade.log


send_user "\n"

send_user ">>>>>  Working on $hostname @ [exec date] <<<<<\n"

send_user "\n"
#######################
spawn ssh -o StrictHostKeyChecking=no $hostname -l $user
expect -re "Connection refused" {
spawn telnet $hostname }


#spawn telnet $hostname
#expect "Username:"
#
#send "$user\n"

expect "Password:"

send "$passwd\n"

expect ">"

send "enable\n"

expect "Password:"

send "$passwd\n"
expect "#"

send "terminal length 0\n"
expect "*#"

send "copy scp://support:$srvpassword@$serverip/$ios flash:\n"
sleep 1
expect "*.bin]?"

send "\r"
set timeout 3600
expect "*#"

send "verify flash:$ios\r"
expect "*#"

send "conf t\r"
expect "*(config)#"

send "boot system flash:$ios\r"
expect "*(config)#"

send "end\n"
expect "*#"
set timeout 2
#send "wr\r"
#expect "*#"

send "exit\r"
expect eof

