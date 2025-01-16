#!/bin/bash
exec > /tmp/user_data.log 2>&1
set -x

# mkfs.ext4 /dev/xvdb
# echo "/dev/xvdb /data ext4 defaults,nofail 0 2" >> /etc/fstab
# mount -a

yum update -y
