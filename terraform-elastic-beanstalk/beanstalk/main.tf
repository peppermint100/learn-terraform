resource "aws_elastic_beanstalk_application" "this" {
  name        = "beanstalk-${var.app_name}"
}

resource "aws_elastic_beanstalk_environment" "this" {
  name                = "env-${var.app_name}"
  application         = aws_elastic_beanstalk_application.this.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.3 running Docker"
}

