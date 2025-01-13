
/*
to create the public key in the local m/c 
this is stored in the ~/.ssh/<key-name>
ssh-keygen
# where to store key: /home/ec2-user/.ssh/test
cat ~/.ssh/<key-name>
# paste this whole string in the public_key = "whole-string"
but we do not want to push this key into the github which is accessible to all users 
# so we refence the file location 
After instance launched ssh to the ec2 instance 
to do this run the following command into the 
ssh ec2-user@<public-ip> -i <private-key-name with location/path>
ssh ec2-user@<public-ip> -i /home/ec2-user/.ssh/test
*/

resource "aws_key_pair" "abc-key" {
    # key_name = same
    key_name = "server-key"
    # public_key = "${file(var.public-key-location)}"
    public_key = file(var.public-key-location)
}

resource "aws_instance" "abc-ec2" {
    ami = data.aws_ami.latest-amazon-linux-image.id
    instance_type = var.ec2-type

    subnet_id = var.subnet[0]
    vpc_security_group_ids = var.abc-sg[0] // [aws_security_group.demo-sg.id]
    availability_zone = var.AZ

    associate_public_ip_address = true
    key_name = aws_key_pair.abc-key.key_name
    # key_name = "deployer-key" # "same" # use key name directly here 

    tags = {
        Name = "${var.env}-abc-server"
    }

    # user_data = file("entry-script.sh") //if file present at the same location
    user_data = file(var.entry-script)
    # once the terraform configures the infrastructure, then terraform will not wait for the instance to come up to run this script.
    # terraform will handover the this script to the cloud provider here its aws-cloud then it aws responsibility  to execute this after the instance will launch. 
}


/*
# this is to create the new key pair. this also delete the key if you terrafrom destroy command 
# ------------------------------
resource "aws_key_pair" "TF_key" {
  key_name   = "deployer-key"
  public_key = tls_private_key.rsa-key.public_key_openssh
}

# To create a ssh key 
# RSA key of size 4096 bits
resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# To store the private key in our pc
resource "local_file" "TF_key" {
  content  = tls_private_key.rsa-key.private_key_pem
  filename = "tfkey"
}
# ------------------------------
*/





resource "aws_ebs_volume" "abc-EBS-storage" {
  # this resource supports the following arguments aws_ebs_volume

  availability_zone = var.AZ

  # kms_key_id - (Optional) The ARN for the KMS encryption key. When specifying kms_key_id, encrypted needs to be set to true.
  # At least one of size or snapshot_id is required when specifying an EBS volume
  # do not create volume from the snapshot
  size              = 1  # in GiBs
 
  # encrypted - (Optional) If true, the disk will be encrypted.
  encrypted = "false"
 
  # final_snapshot - (Optional) If true, snapshot will be created before volume deletion. Any tags on the volume will be migrated to the snapshot. By default set to false
  //final_snapshot = "false"
 
  # iops - (Optional)
  iops = "3000" # min-3000  max-16000. Valid for type - io1, io2, gp3

  # multi_attach_enabled - (Optional) Specifies whether to enable Amazon EBS Multi-Attach. 
  # Multi-Attach is supported on io1 and io2 volumes.
  # multi_attach_enabled = ""
  
  type = "gp3"  # gp3, gp2, io1, io2, sc1, st1 
  throughput = 125 # in MiB/s min.-125 max.-1000 only valid for gp3

  tags = {
    Name = "${var.env}-EBS"
  }
}

resource "aws_volume_attachment" "abc-ebs-att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.abc-EBS-storage.id
  instance_id = aws_instance.abc-ec2.id
}