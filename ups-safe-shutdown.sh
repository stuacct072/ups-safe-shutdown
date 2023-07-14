#!/bin/bash

target_ip=192.168.2.1
failure_count=0
shutdown_failure_count_threshold=20

while :
do
  ping -c 1 $target_ip &> /dev/null
  if [ $? -eq 0 ]; then
    ((failure_count=0))
  else
    ((failure_count++))
  fi
  sleep 10s
  if [ $failure_count -eq $shutdown_failure_count_threshold ]; then
    /sbin/shutdown -hP now
    break
  fi
done

exit 0
