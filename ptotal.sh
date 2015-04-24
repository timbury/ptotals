#!/bin/sh
#
# Copyleft 2015 Tim Kissane
#
# ptotals.sh - Get total memory and cpu usage from a given set of processes.


# Start the interactive version
echo "What process do you want to check (ex. chrome)?"

read process

# Does process exist? If not, exit.
found=`pgrep $process`
if [ "$found" = "" ]; then
    echo "Process $process not found. Try using 'ps ax'."
    exit
fi

echo "Which resource do you want to check? [cpu|mem|both]"

read resource

if [ "$resource" = "cpu" ]; then
    cpu_list=""
    cpu_list=`ps aux | tr -s " " | grep $process | cut -f3 -d" "`
    cpu_total=0
    for i in $cpu_list; do cpu_total=$(echo $cpu_total + $i | bc); done
    echo "$process is using $cpu_total percent of cpu usage."
elif [ "$resource" = "mem" ]; then
    mem_list=""
    mem_list=`ps aux | tr -s " " | grep $process | cut -f4 -d" "`
    mem_total=0
    for i in $mem_list; do mem_total=$(echo $mem_total + $i | bc); done
    echo "$process is using $mem_total percent of memory usage."
elif [ "$resource" = "both" ]; then
    cpu_list=""
    cpu_list=`ps aux | tr -s " " | grep $process | cut -f3 -d" "`
    cpu_total=0
    for i in $cpu_list; do cpu_total=$(echo $cpu_total + $i | bc); done
    mem_list=""
    mem_list=`ps aux | tr -s " " | grep $process | cut -f4 -d" "`
    mem_total=0
    for i in $mem_list; do mem_total=$(echo $mem_total + $i | bc); done
    echo "$process is using $cpu_total percent of cpu usage and $mem_total percent of memory usage."
else
    echo "Resource must be cpu, mem, or both."
fi

exit 0

