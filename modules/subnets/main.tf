resource "aws_subnet" "abc-subnet-1-pub" {
    //provider = demo-aws.aws_lab  
    vpc_id = var.vpc-name[0]
    cidr_block = var.subnet_cidr_block[0]
    availability_zone = var.AZ
    tags = {
        Name: "${var.env}-abc-subnet-1-pub"
        env: var.env
    }
}

resource "aws_subnet" "abc-subnet-2-private" {
    //provider = demo-aws.aws_lab 
    vpc_id = var.vpc-name[0]
    cidr_block = var.subnet_cidr_block[1]
    availability_zone = var.AZ
    tags = {
        Name = "${var.env}-abc-subnet-2-private"
    }
}

resource "aws_internet_gateway" "abc-igw" {
    // provider = demo-aws.aws_lab
    vpc_id = var.vpc-name[0]
}

# create the new route table. which is the best practice 
resource "aws_route_table" "abc-route-table" {
    // vpc_id = var.vpc-name[0].id
    vpc_id = var.vpc-name[0]
    route {
        cidr_block = "0.0.0.0/0"
        # gateway id is the IGW id
        gateway_id = aws_internet_gateway.abc-igw.id
    }
    tags = {
        Name: "${var.env}-rt"
    }
}

# Associate the subnet with the route table 
resource "aws_route_table_association" "abc-rtb-subnet" {
    subnet_id = aws_subnet.abc-subnet-1-pub.id
    route_table_id = aws_route_table.abc-route-table.id
}

resource "aws_security_group" "abc-sg" {
    name = "demo-sg1"
    vpc_id = var.vpc-name[0]

    ingress {
        from_port = 22
        to_port = 22
        protocol =  "tcp"
        cidr_blocks = [var.myip]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol =  "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

# allow any traffic to leave from the server 
    egress {
        from_port = 0   // here zero means any ip 
        to_port = 0     // here also zero means any ip 
        protocol = "-1"     // -1 means all protocoll
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name : "${var.env}-sg1"
    }
}