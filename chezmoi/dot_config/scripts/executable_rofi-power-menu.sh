#!/bin/sh

lang_pc_shutdown="shutdown"
lang_pc_reboot="restart"
lang_pc_logout="logout"
lang_pc_lock="lock"
lang_notification_name="Power manager"
lang_notificaton_shutdown="A power off request has been sent. The computer should shut down in a moment."

# Icons
lang_pc_shutdown=" $lang_pc_shutdown"
lang_pc_reboot="󰜉 $lang_pc_reboot"
lang_pc_logout="󰗽 $lang_pc_logout"
lang_pc_lock=" $lang_pc_lock"

selected=$(
    printf "%s\n%s\n%s\n%s\n" \
        "$lang_pc_shutdown" "$lang_pc_reboot" "$lang_pc_logout" "$lang_pc_lock" | 
    rofi -dmenu -p "powermenu" -lines 4
)

case $selected in
    "$lang_pc_shutdown")
        notify-send "$lang_notification_name" "$lang_notificaton_shutdown"
        shutdown -h now
        ;;

    "$lang_pc_reboot")
        notify-send "$lang_notification_name" "$lang_notificaton_shutdown"
        reboot
        ;;

    "$lang_pc_logout")
        case "$XDG_CURRENT_DESKTOP" in
            "dwm")
                killall dwm
                ;;

            "i3")
                i3-msg exit
                ;;
        esac
        ;;

    "$lang_pc_lock")
        light-locker-command --lock
        ;;
esac
