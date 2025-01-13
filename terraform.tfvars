public-key-location = "/home/ec2-user/.ssh/test.pub"
ec2-type = "t2.micro"
// subnet = ["", ""]
AZ = "us-east-1a"
env = "dev"
entry-script = "./entry-script-files/entry-script.sh"

subnet-cidr-blocks = ["10.0.10.0/24", "10.0.1.0/24"]
myip = "0.0.0.0/0"

vpc_cidr_block = ["10.0.0.0/20", "10.1.0.0/20"]