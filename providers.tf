terraform {
  required_version = "~> 1.8.4"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.21"
    }
  }

  backend "s3" {
    bucket = "demo512"
    key    = "terraform/state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "aws_lab"
  profile = "default"
  region  = "us-east-1"
}
