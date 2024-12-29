terraform {
  required_version = "~> 1.8.4"

  required_providers {
    demo-aws = {
      source = "hashicorp/aws"
      version = "~> 3.21"
    }
/*
    demo_azure = {
        source = ""
        version = ""
    }
*/
  }
    backend "s3" {
    bucket = "demo512"
    key = "terraform/state.tfstate"
    region = "us-east-1"
  }
}


provider demo-aws {
  profile = "default"
  region = "us-east-1"
  //access_key = "xyz"
  //secret_key = "xyz"
  alias = "aws_lab"
}