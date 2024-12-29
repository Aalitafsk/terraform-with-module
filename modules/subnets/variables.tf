variable "subnet_cidr_block" {
    description = "subnet cidr block"
    default = ["10.0.10.0/32", "10.0.0.0/16"]
    type = list(string) 
}
variable "AZ" {}
variable "env" {}
variable "vpc-name" {
    description = "vpc name"
    type = list(string)
    // default = ["10.0.10.0/32", "10.0.0.0/16"]
}
variable "myip" {}