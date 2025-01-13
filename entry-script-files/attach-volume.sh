# to attch the volume in such a way that on reboot also this volume get automatically attach to this ec2 m/c


#!/bin/bash 

sudo hostname abc 
bash
sudo mkdir  /var/lib/jenkins
 
lsblk
sudo file -s /dev/xvdf
sudo mkfs.ext4 /dev/xvdf 

# sudo blkid
ls /etc/ | grep fstab
sudo cp /etc/fstab  /etc/fstab.orgi
ls /etc/ | grep fstab

sudo mount /dev/xvdf /var/lib/jenkins

sudo vi /etc/fstab
# add the following line in this file 
UUID=8422ca8d-44e9-488d-bcc8-1ebf345fd170 /var/lib/jenkins ext4  defaults,nofail 0 2

/dev/xvdf    /var/lib/jenkins    ext4    defaults,nofail    0    2


sudo systemctl daemon-reload
sudo mount -a