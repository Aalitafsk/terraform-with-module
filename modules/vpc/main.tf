
// In this we create the vpc 

resource "aws_vpc" "abc-vpc" {
    cidr_block = var.vpc_cidr_block[0]
    tags = {
        Name: "${var.env}-abc-vpc"
        env: "${var.env}"
    }
}


resource "aws_vpc" "xyz-vpc" {
    cidr_block = var.vpc_cidr_block[1]
    tags = {
        Name: "${var.env}-xyz-vpc"
        env: "${var.env}"
    }
}