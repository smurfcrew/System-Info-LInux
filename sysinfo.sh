#!/bin/bash

# Description: Bash script that displays system information.
# Input: sysinfo.sh <sys|mem|disk>
# Output: Displays system information based on the input parameter.

# List of system calls
HOSTNAME=$(hostname)
UPTIME=$(uptime | awk '{print $3, $4}' | sed 's/,//')
MANUFACTURER=$(cat /sys/class/dmi/id/chassis_vendor)
PRODUCTNAME=$(cat /sys/class/dmi/id/product_name)
VERSION=$(cat /sys/class/dmi/id/product_version)
MACHINE_TYPE=$(vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi)
OPERATING_SYSTEM=$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)
KERNEL_VERSION=$(uname -r)
ARCHITECTURE=$(uname -m)
PROCESSOR=$(awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//')
MAIN_SYS_IP=$(hostname -I)

# List of memory calls
MEM_USAGE=$(free | awk '/Mem/{printf("Memory Usage: \t\t%.2f%%"), $3/$2*100}')
SWAP_USAGE=$(free | awk '/Swap/{printf("Swap Usage: \t\t%.2f%%"), $3/$2*100}')
CPU_USAGE=$(cat /proc/stat | awk '/cpu/{printf("CPU Usage: \t\t%.2f%%\n"), ($2+$4)*100/($2+$4+$5)}' | head -1)

# List of disk calls
DISK_USAGE=$(df -h | awk '$NF=="/"{printf "Disk Usage: %s\t\t\n\n", $5}')

# Functions
print_sys_info() {
    echo "-------------------------------System Information---------------------------"
    echo "Hostname: $HOSTNAME"
    echo "Uptime: $UPTIME"
    echo "Manufacturer: $MANUFACTURER"
    echo "Product Name: $PRODUCTNAME"
    echo "Version: $VERSION"
    echo "Machine Type: $MACHINE_TYPE"
    echo "Operating System: $OPERATING_SYSTEM"
    echo "Kernel: $KERNEL_VERSION"
    echo "Architecture: $ARCHITECTURE"
    echo "Processor Name: $PROCESSOR"
    echo "Active User: $USER"
    echo "Main System IP: $MAIN_SYS_IP"
}

print_mem_info() {
    echo "-------------------------------CPU/Memory Usage------------------------------"
    free | sed 's/^//'
    echo
    MEM_USAGE_PERCENT=$(free | awk '/Mem/{printf("%.2f%%"), $3/$2*100}')
    echo "Memory Usage: $MEM_USAGE_PERCENT"
    SWAP_USAGE_PERCENT=$(free | awk '/Swap/{printf("%.2f%%"), $3/$2*100}')
    echo "Swap Usage: $SWAP_USAGE_PERCENT"
    CPU_USAGE_PERCENT=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "CPU Usage: $CPU_USAGE_PERCENT%"
}

print_disk_info() {
    echo "-------------------------------Disk Usage-------------------------------"
    echo "$DISK_USAGE"
    echo
    echo -e "Filesystem Size Used Avail Use Mounted on"
    df -Pha -t squashfs | sed -e 's/^/ /' -e 's/%//g'
}

# Function to print usage
usage() {
    echo "Usage: sysinfo.sh <sys|mem|disk>"
}

# Main Script
if [ $# -ne 1 ]; then
    usage
else
    case $1 in
        sys)
            print_sys_info
            ;;
        mem)
            print_mem_info
            ;;
        disk)
            print_disk_info
            ;;
        *)
            echo "Error, invalid parameter."
            usage
            ;;
    esac
fi