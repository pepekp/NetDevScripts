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


#spawn telnet $hostname

expect "Username:"

send "$user\n"

expect "Password:"

send "$passwd\n"
expect ">"

send "enable\n"
expect "Password:"

send "$passwd\n"
expect "*#"

send "terminal length 0\n"
expect "*#"

send "copy ftp://anonymous:$srvpassword@$serverip/ios/9300/$ios flash:\r"
expect "*.bin]?"

send "\r"
expect "*#"

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

