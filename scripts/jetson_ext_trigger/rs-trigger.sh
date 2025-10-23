#!/bin/bash

set -e

if [[ $# < 3 ]]; then
    echo "rs-trigger.sh [pin-id] [period] [duty-cycle]"
    echo "e.g., rs-trigger.sh 18 33333333 16666666"
    echo "Note: Units are in nanoseconds"

    # Show Result
    sudo cat /sys/kernel/debug/pwm
    exit 1
else
    case "$1" in
    "13")
        echo "Pin 13"
	ID=3
        ;;
    "15")
        echo "Pin 15"
	ID=0
        ;;
    "18")
        echo "Pin 18"
	ID=2
        ;;
    *)
        echo "Default Pin 18"
        ID=2
	;;
    esac

    # ID=$1    # Pin18 = 2, Pin15 = 0, pin 13 = 3
    PERIOD=$2
    DUTY_CYCLE=$3

    # Export pwm id if not already
    if [[ -e "/sys/class/pwm/pwmchip$ID/pwm0" ]]; then
	echo "PWM Exported"
    else
        sudo echo 0 > /sys/class/pwm/pwmchip$ID/export
	sleep 2
    fi
    
    echo "Period = $PERIOD ns"
    sudo echo $PERIOD > /sys/class/pwm/pwmchip$ID/pwm0/period
    echo "Duty Cycle = $DUTY_CYCLE ns"
    sudo echo $DUTY_CYCLE > /sys/class/pwm/pwmchip$ID/pwm0/duty_cycle
    sudo echo 1 > /sys/class/pwm/pwmchip$ID/pwm0/enable

    # Show Result
    sudo cat /sys/kernel/debug/pwm
fi
