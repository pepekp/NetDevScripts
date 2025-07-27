#!/usr/bin/expect -f

set user "admin"
set hostname [lindex $argv 0]
set ios "cat9k_iosxe.16.12.06.SPA.bin"
set serverip [lindex $argv 3]
set srvpassword [lindex $argv 2]
set passwd [lindex $argv 1]

set timeout 2


log_file -a ./joblog/ios_upgrade.log


send_user "\n"

send_user ">>>>>  Working on $hostname @ [exec date] <<<<<\n"

send_user "\n"

spawn ssh -o StrictHostKeyChecking=no $hostname -l $user
expect -re "Connection refused" {
spawn telnet $hostname }

#expect "Username:"
#send "$user\n"

expect "Password:"

send "$passwd\n"
expect ">"
sleep 1
send "enable\r"
expect "Password:"

send "$passwd\n"
expect "*#"


send "copy scp://support:$srvpassword@$serverip/$ios flash:\r"
sleep 1
expect "*.bin]?"

send "\r"
set timeout -1
expect "*#"
set timeout 2
send "request platform software package install switch all file flash:$ios\r"
expect "*#"

send "conf t\r"
expect "*(config)#"


send "boot system flash:$ios\r"
expect "*(config)#"

send "end\n"
expect "*#"

#send "wr\r"
#expect "*#"

send eof

