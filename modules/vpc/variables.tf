
variable "vpc_cidr_block" {
    type = list(string)
    description = "vpc cidr block"
    default = ["10.0.0.0/20", "10.1.0.0/20"]
}

variable "env" {
    type = string
    description = "vpc environment"
    default = "dev"
}

// variable "vpc-lists" {}