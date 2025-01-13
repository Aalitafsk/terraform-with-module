variable "public-key-location" {}
variable "ec2-type" {}
variable "subnet" {
    description = "List of subnet IDs"
    type        = list(string)
}
variable "abc-sg" {}
variable "AZ" {}
variable "env" {}
variable "entry-script" {}