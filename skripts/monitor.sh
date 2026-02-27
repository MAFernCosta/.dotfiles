#!/bin/bash
# Program: monitor.sh
# Description: Monitors the hardware temperature and usage.
# Date: 04.02.26

set -u 

cpuTemp=$(sensors | grep CPU | awk '{print $2}')

gpuTemp=$(sensors | grep GPU | awk '{print $2}')

echo "CPU: $cpuTemp GPU: $gpuTemp"
