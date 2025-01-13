variable "public-key-location" {}
variable "ec2-type" {}
variable "subnet" {
    description = "List of subnet IDs"
    type        = list(string)
}
variable "abc-sg" {
    description = "List of security group IDs"
    type        = list(string)
}
variable "AZ" {}
variable "env" {}
variable "entry-script" {}