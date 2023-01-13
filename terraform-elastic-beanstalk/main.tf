terraform {
  backend "s3" {
    bucket = "tnear-terraform-backend"
    key    = "state"
    region = "ap-northeast-2"
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

module "vpc" {
  source = "./vpc"
  vpc_id = var.TFE_VPC_ID
}

module "security-group" {
  source     = "./security-group"
  app_name   = var.app_name
  vpc_id     = module.vpc.vpc_id
  allowed_ip = [var.TFE_PERSONAL_IP, var.TFE_SSH_IP]
}

module "load-balancer" {
  source              = "./load-balancer"
  app_name            = var.app_name
  target_group_arn    = module.elastic-beanstalk.autoscaling_groups
  sg_load_balancer_id = module.security-group.sg_load_balancer_id
  certificate_arn     = var.TFE_CERTIFICATE_ARN
  subnet_ids          = module.vpc.subnet_ids
}

module "elastic-beanstalk" {
  source                      = "./beanstalk"
  app_name                    = var.app_name
  service_role_arn            = var.TFE_BEANSTALK_SERVICE_ARN
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.subnet_ids
  ami_id                      = var.TFE_AMI_ID
  instance_type               = "t3.micro"
  security_groups             = [module.security-group.sg_instance_id]
  health_check_path           = "/api/health"
  key_name                    = var.TFE_KEY_NAME
  notification_endpoint_email = "krpeppermint100@gmail.com"
}