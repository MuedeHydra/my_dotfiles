#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Hibernate" | tofi --font="CommitMono" | awk '{print tolower($2)}' )

case $op in
        poweroff)
                sudo shutdown -h 0
                ;;
        reboot)
                sudo reboot
                ;;
        suspend)
                # sudo hibernate-ram
                systemctl suspend
                ;;
        lock)
                hyprlock
                ;;
        hibernate)
                sudo hibernate
                ;;
esac
