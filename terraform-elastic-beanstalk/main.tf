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

module "security-group" {
  source   = "./security-group"
  app_name = var.app_name
  vpc_id   = var.vpc_id
}