terraform {
  cloud {
    organization = "peppermint100-org"
    workspaces {
      name = "learn-tfc-aws"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-8745e7e9"
  instance_type = "t3.micro"

  tags = {
    Name = var.instance_name
  }
}