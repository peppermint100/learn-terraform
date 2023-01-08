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

module vpc {
  source = "./vpc"
  vpc_id = var.vpc_id
}

module "security-group" {
  source     = "./security-group"
  app_name   = var.app_name
  vpc_id     = module.vpc.vpc_id 
  allowed_ip = [var.TFC_PERSONAL_IP, var.TFC_SSH_IP]
}

module "load-balaner" {
  source = "./load-balancer"
  app_name = var.app_name 
  target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-2:998251115309:targetgroup/dummy-target-group/d8ca455eaf3a4b85"
  sg_load_balancer_id = module.security-group.sg_load_balancer_id
  certificate_arn = var.TFC_CERTIFICATE_ARN
  subnet_ids = module.vpc.subnet_ids
}