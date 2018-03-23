#!/bin/bash
#############################################################
##### Useful push notifications to device with Pushover #####
### for main information look at https://pushover.net/api ###
######## User defined parameters, fill with yours. ##########
pushover_token=""
pushover_user=""
####### Do not modify anything below this line ##############
#############################################################
me="PowerPush v0.1a - 21 marzo 2018"
if [ $1 == "Send" ]
then
# Send
echo $me
curl -s \
  --form-string "token=$pushover_token" \
  --form-string "user=$pushover_user" \
  --form-string "message=$3" \
  --form-string "priority=$2" \
  --form-string "retry=60" \
  --form-string "expire=10800" \
  https://api.pushover.net/1/messages.json
exit
elif [ $1 == "Help" ]
then
# Help
        echo 'Syntax: powerpush Method (Send/Help) Priority 0/1/2 Text'
        echo "The Priority parameter cause this scenario:"
        echo " "
        echo "0=Normal"
        echo "These messages trigger sound, vibration, and display an alert according"
        echo "to the user's device settings. On iOS, the message will display at the"
        echo "top of the screen or as a modal dialog, as well as in the notification"
        echo "center. On Android, the message will scroll at the top of the screen"
        echo "and appear in the notification center."
        echo "If a user has quiet hours set and your message is received during those"
        echo "times, your message will be delivered silently."
        echo " "
        echo "1=High"
        echo "Messages sent with High priority bypass a user's quiet hours."
        echo 'These messages will always play a sound and vibrate  (if the user'
        echo 'device is configured to) regardless of the delivery time. '
        echo "High-priority messages are highlighted in red in the device clients."
        echo " "
        echo "2=Emergency"
        echo "Emergency-priority notifications are similar to high-priority"
        echo "notifications, but they are repeated until the notification is"
        echo "acknowledged by the user. These are designed for dispatching and"
        echo "on-call situations where it is critical that a notification be"
        echo "repeatedly shown to the user. They are sent with a retry parameter"
        echo 'of 60 seconds and an expire parameter for 3 hour (10800 seconds).'
        echo " "
        echo '"Example: powerpush Method Send 1 "DISK FAILURE ON DC SERVER "'
        exit
else
        echo "Syntax Error!"
        echo "Syntax: powerpush Method (Send/Help) Priority (0/l/2) Text"
        echo '"Example: powerpush Method Send 1 "DISK FAILURE ON DC SERVER "'
        exit
fi
