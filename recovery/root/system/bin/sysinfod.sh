#!/system/bin/sh

rotate()
{
    local MAXLOG=$1
    local prefix=$2
    for i in `seq $((MAXLOG-1)) -1 1`; do
        [ -f ${prefix}".$i" ] && mv ${prefix}"."{$i,$((i+1))}    #will need to ignore file not found errors here
    done
    [ -f ${prefix} ] && mv ${prefix} ${prefix}.1    # since a file descriptor is linked to an inode rather than path,
                    #if you move (or even remove) an open file, the program will continue
                    #to write into it as if nothing happened
                    #see https://stackoverflow.com/questions/5219896/how-do-the-unix-commands-mv-and-rm-work-with-open-files
}

#get size in mb <-- `du -m $filename | cut -f1`
OUTPUT_PATH=$1
OUTPUT_PREFIX=$1/sysinfo
MAX_OUTPUT_FILE_SIZE=5
MAX_OUTPUT_ROTATE_COUNT=10
MONITOR_INTERVAL=600
TIME_CONSUMING_CMD=("ramparser -m" "ramparser -a" "ramparser -m" "dmabuf_dump")
TIME_CONSUMING_CMD_CNT=${#TIME_CONSUMING_CMD[@]}
TIME_CONSUMING_CMD_IDX=0

main()
{
echo sysinfod start up now...
echo OUTPUT_PATH: $OUTPUT_PATH
echo OUTPUT_PREFIX: $OUTPUT_PREFIX
echo MAX_OUTPUT_FILE_SIZE: $MAX_OUTPUT_FILE_SIZE
echo MAX_OUTPUT_ROTATE_COUNT: $MAX_OUTPUT_ROTATE_COUNT
echo MONITOR_INTERVAL: $MONITOR_INTERVAL

while true
do
debug_enabled=`getprop androidboot.sysinfod.debug.enable`
if [ x$debug_enabled = x1 ]; then
set -x
fi

local TIME_STAMP=[`date +"%Y-%m-%d %H:%M:%S"`][`cat /proc/uptime|cut -f1 -d" "`]
(
#time stamp
#date +"%Y-%m-%d %H:%M:%S"
#dump
echo;echo $TIME_STAMP /proc/meminfo ;cat /proc/meminfo
echo;echo $TIME_STAMP /proc/buddyinfo ;cat /proc/buddyinfo
echo;echo $TIME_STAMP /proc/slabinfo ;cat /proc/slabinfo
echo;echo $TIME_STAMP /proc/zoneinfo ;cat /proc/zoneinfo
echo;echo $TIME_STAMP /proc/vmstat ;cat /proc/vmstat
#echo;echo /proc/vmallocinfo ;cat /proc/vmallocinfo
echo;echo $TIME_STAMP /proc/pagetypeinfo ;cat /proc/pagetypeinfo
echo;echo $TIME_STAMP /d/wakeup_sources ;cat /d/wakeup_sources
#echo;echo /sys/kernel/debug/binder/failed_transaction_log ;cat /sys/kernel/debug/binder/failed_transaction_log
#echo;echo /sys/kernel/debug/binder/transaction_log ;cat /sys/kernel/debug/binder/transaction_log
#echo;echo /sys/kernel/debug/binder/transactions ;cat /sys/kernel/debug/binder/transactions
#echo;echo /sys/kernel/debug/binder/stats ;cat /sys/kernel/debug/binder/stats
#echo;echo /sys/kernel/debug/binder/state ;cat /sys/kernel/debug/binder/state
echo;echo $TIME_STAMP /proc/interrupts;cat /proc/interrupts
) >> $OUTPUT_PREFIX

#time consuming cmd process one every loop
echo >>$OUTPUT_PREFIX
echo $TIME_STAMP ${TIME_CONSUMING_CMD[$TIME_CONSUMING_CMD_IDX]}>>$OUTPUT_PREFIX
nice -n 20 ${TIME_CONSUMING_CMD[$TIME_CONSUMING_CMD_IDX]}>>$OUTPUT_PREFIX
#echo TIME_CONSUMING_CMD_IDX=$((($TIME_CONSUMING_CMD_IDX+1)%$TIME_CONSUMING_CMD_CNT))
let TIME_CONSUMING_CMD_IDX=$((($TIME_CONSUMING_CMD_IDX+1)%$TIME_CONSUMING_CMD_CNT))

sleep $MONITOR_INTERVAL
#roate output file if necessary
[ `du -m $OUTPUT_PREFIX|cut -f1` -gt $MAX_OUTPUT_FILE_SIZE ] && \
    rotate $MAX_OUTPUT_ROTATE_COUNT $OUTPUT_PREFIX
done
}

#wrap all we do so we can pipe output to logcat (through log command)
#instead of some NULL device, which is default behavior for android service
main 2>&1 | log -t sysinfod

