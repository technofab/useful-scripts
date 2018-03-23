<# 
    PowerPush - Sending Push Notifications via PowerShell
    It use Pushover: https://pushover.net/api
#>
Param(
    [Parameter(Mandatory=$True,Position=1)]
    [string] $Method,
    [Parameter(Mandatory=$True,Position=2)]
    [string] $Priority,
    [Parameter(Mandatory=$true,Position=3)]
    [string] $Text
)
#############################################################
##### Useful push notifications to device with Pushover #####
### for main information look at https://pushover.net/api ###
######## User defined parameters, fill with yours. ##########
pushover_token=""
pushover_user=""
####### Do not modify anything below this line ##############
#############################################################
$Me = "PowerPush v0.1a - 21 marzo 2018"
Write-Output $Me
$Method = $Method.ToLower()
$Priority = $Priority.ToLower()
# Check Powershell Version
# If ($PSVersionTable.PSVersion.Major -le 2) { "Less than or equal 2" } Else { "Greater than 2" }

If ($Method -eq "send") {
# Send push via PushOver

If ($Priority -eq "normal") {
$MessagePriority="0"
}
ElseIf ($Priority -eq "high") {
$MessagePriority="1"
} 
ElseIf ($Priority -eq "emergency") {
$MessagePriority="2"
} 
Else {
# Exit script
Write-Output "Syntax Error!"
Write-Output "Syntax: PowerPush.ps1 Method (Send/Help) Priority (Normal/High/Emergency) Text"
Write-Output "Example: PowerPush.ps1 Method Send High ""DISK ON DC SERVER BROKEN"""
Exit
} 

Write-Output "Send push via PushOver"
$POSTParameters = New-Object System.Collections.Specialized.NameValueCollection
$POSTParameters.Add("token", $pushover_token)
$POSTParameters.Add("user", $pushover_user)
$POSTParameters.Add("message", $Text)
$POSTParameters.Add("priority", $MessagePriority)
$POSTParameters.Add("retry", "60")
$POSTParameters.Add("expire", "10800")
$WebClient = New-Object System.Net.WebClient
$WebClient.UploadValues("https://api.pushover.net/1/messages.json", $POSTParameters)
Exit
} 
ElseIf ($Method -eq "help") {
Write-Output "Syntax: PowerPush.ps1 Method (Send/Help) Priority (Normal/High/Emergency) Text
The Priority parameter cause this scenario:

Normal
These messages trigger sound, vibration, and display an alert according
to the user's device settings. On iOS, the message will display at the 
top of the screen or as a modal dialog, as well as in the notification 
center. On Android, the message will scroll at the top of the screen 
and appear in the notification center.
If a user has quiet hours set and your message is received during those
times, your message will be delivered silently.

High
Messages sent with High priority bypass a user's quiet hours. 
These messages will always play a sound and vibrate  (if the user's 
device is configured to) regardless of the delivery time. 
High-priority messages are highlighted in red in the device clients.

Emergency
Emergency-priority notifications are similar to high-priority 
notifications, but they are repeated until the notification is 
acknowledged by the user. These are designed for dispatching and 
on-call situations where it is critical that a notification be 
repeatedly shown to the user. They are sent with a retry parameter 
of 60 seconds and an expire parameter for 3 hour (10800 seconds).

Example: PowerPush.ps1 Method Send High ""DISK ON DC SERVER BROKEN"""
Exit 
}
Else {
# Exit script
Write-Output "Syntax Error!"
Write-Output "Syntax: PowerPush.ps1 Method (Send/Help) Priority (Normal/High/Emergency) Text"
Write-Output "Example: PowerPush.ps1 Method Send High ""DISK ON DC SERVER BROKEN"""
Exit
}
