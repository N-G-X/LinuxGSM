#!/bin/bash
# LinuxGSM alert_discord.sh function
# Author: Daniel Gibbs
# Contributor: faflfama
# Website: https://gameservermanagers.com
# Description: Sends Discord alert.

json=$(cat <<EOF
{
"username":"Server Ninja",
"avatar_url":"https://raw.githubusercontent.com/N-G-X/LinuxGSM/master/images/logo/NinjaheadFinal.png",
"file":"content",

"embeds": [{
        "color": "2067276",
        "author": {"name": "${alertemoji} ${alertsubject} ${alertemoji}", "icon_url": "https://raw.githubusercontent.com/N-G-X/LinuxGSM/master/images/logo/NinjaheadFinal.png"},
        "title": "",
        "description": "",
        "url": "",
        "type": "content",
        "thumbnail": {"url": "https://raw.githubusercontent.com/N-G-X/LinuxGSM/master/images/logo/NinjaheadFinal.png"},
        "footer": {"text": "Server Ninja", "icon_url": "https://raw.githubusercontent.com/N-G-X/LinuxGSM/master/images/logo/NinjaheadFinal.png"},
        "fields": [
                        {
                                "name": "Alert Message",
                                "value": "${alertbody}"
                        },
                        {
                                "name": "Game",
                                "value": "${gamename}"
                        },
                        {
                                "name": "Server name",
                                "value": "${servername}"
                        },
                        {
                                "name": "Hostname",
                                "value": "${HOSTNAME}"
                        },
                        {
                                "name": "Server IP",
                                "value": "[64.183.143.74:27017](https://www.gametracker.com/server_info/64.183.143.74:27017)"
                        },
                        {
                                "name": "More info",
                                "value": "${alerturl}"
                        }
                ]
        }]
}
EOF
)

fn_print_dots "Sending Discord alert"
sleep 0.5
discordsend=$(${curlpath} -sSL -H "Content-Type: application/json" -X POST -d """${json}""" ${discordwebhook})

if [ -n "${discordsend}" ]; then
        fn_print_fail_nl "Sending Discord alert: ${discordsend}"
        fn_script_log_fatal "Sending Discord alert: ${discordsend}"
else
        fn_print_ok_nl "Sending Discord alert"
        fn_script_log_pass "Sending Discord alert"
fi
