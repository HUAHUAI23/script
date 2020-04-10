#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html
# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.

print_mem(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memfree"
}


print_date(){
date '+%Y年%m月%d日 %H:%M'
#	date '+%H:%M'
}

export IDENTIFIER="unicode"



dwm_battery () {
    # Change BAT1 to whatever your battery is identified as. Typically BAT0 or BAT1
    CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)

    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        if [ "$STATUS" = "Discharging" ]; then
						printf "🔋%s%%" "$CHARGE"
#           printf "🔋 %s%% %s" "$CHARGE" "$STATUS"
					else
#						printf "🔌 %s%% %s" "$CHARGE" "$STATUS"
						printf "🔌%s%%" "$CHARGE"
        fi
    else
        printf "BAT %s%% %s" "$CHARGE" "$STATUS"
    fi
    printf "%s\n" "$SEP2"
}


dwm_backlight () {
    printf "%s☀ %.0f%s\n" "$SEP1" "$(xbacklight)" "$SEP2"
}
cpu_temperature () {
	TMP=$(cat /sys/class/thermal/thermal_zone0/temp)
	let "TEMP=($TMP/1000)"
		printf " %s"  $TEMP
	}

#cpu_used (){

#		TIME_INTERVAL=1
#		 
#		LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
#		LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
#		LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
#		sleep ${TIME_INTERVAL}
#		NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
#		NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
#		NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
#		 
#		#系统空闲时间
#		SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
#		#CPU总时间
#		TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`
#		CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`
#		printf " %s%%" $CPU_USAGE
#}

#dwm_date () {
#    printf "%s" "$SEP1"
#    if [ "$IDENTI;FIER" = "unicode" ]; then
#        printf "📆 %s" "$(date "+%a %d-%m-%y %T")"
#    else
#        printf "DAT %s" "$(date "+%a %d-%m-%y %T")"
#    fi
#    printf "%s\n" "$SEP2"
#}
xsetroot -name " 💿 $(print_mem)M $(cpu_temperature)度 $(dwm_backlight) $(dwm_battery) $(print_date)"


exit 0
