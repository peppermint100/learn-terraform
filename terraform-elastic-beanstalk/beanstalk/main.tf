resource "aws_elastic_beanstalk_application" "this" {
  name        = "beanstalk-${var.app_name}"

  appversion_lifecycle {
    service_role          = var.service_role_arn
    max_count             = 128
    delete_source_from_s3 = true
  }
}

resource "aws_elastic_beanstalk_environment" "this" {
  name                = "env-${var.app_name}"
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.3 running Docker"

  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = var.vpc_id
  }
}

