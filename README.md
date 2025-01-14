this is the trial one 

sudo terraform apply --auto-approve
sudo terraform destroy --auto-approve


run this command in the terminal 
ssh-keygen
# the following values 
 /home/ec2-user/.ssh/test

 # to ssh to new ec2 m/c 
 sudo ssh ec2-user@<public-ip> -i /home/ec2-user/.ssh/test

 # To destroy the all the resources first unmount all the volumes using the following command in the linux terminal of all the servers
 sudo umount /dev/xvdf 

 # now our next step is to take the snapshots/backup of the volumes in aws a/c 
  