#!/usr/bin/expect -f
# auto install acunetix_trial
 
set timeout -1
set send_human {.1 .3 1 .05 2}
 
spawn bash /root/acunetix_trial.sh
 
# expect "press ENTER to continue\r"
expect ">>>"
 
send -h "\r\n"
send -h "\x03"
 
expect "Accept the license terms?"
send -h "yes\r"
 
expect "Insert new hostname, or leave blank to use"
send -h "\r"
 
expect "Email:"
send -h "awvs@zzwul.com\r"
expect "Password:"
send -h "123qwe!@#\r"
expect "Password again:"
send -h "123qwe!@#\r"
expect eof