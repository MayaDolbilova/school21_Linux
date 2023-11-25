#!/usr/bin/expect -f
spawn ./copy.sh

expect {
	"*fingerprint*" { send -- "yes\r"; exp_continue }
	"*password*" { send -- "34128359maya\r" }
}
expect {
    "*fingerprint*" { send -- "yes\r"; exp_continue }
    "*password*" { send -- "34128359maya\r" }
}
expect {
    "*fingerprint*" { send -- "yes\r"; exp_continue }
    "*password*" { send -- "34128359maya\r" }}
expect EOF
