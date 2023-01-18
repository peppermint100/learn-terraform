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
  tier = "WebServer"

  # Instance
  setting {
    name = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value = join(",", var.security_groups)
  }

  # Capacity
  setting {
    name      = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "LoadBalanced"
  }

  setting {
    name      = "LoadBalancerType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "application"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = 1
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = 2
  }

  setting {
    name      = "LoadBalancerIsShared"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "true"
  }

  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "SharedLoadBalancer"
    value     = var.load_balancer_arn
  }

  setting {
    name      = "InstanceTypes"
    namespace = "aws:ec2:instances"
    value     = "t3.micro"
  }

  setting {
    name      = "ImageId"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.ami_id
  }

  # Load Balancer
  setting {
    name      = "MatcherHTTPCode"
    namespace = "aws:elasticbeanstalk:environment:process:default"
    value     = 200
  }

  setting {
    name      = "HealthCheckPath"
    namespace = "aws:elasticbeanstalk:environment:process:default"
    value     = var.health_check_path
  }

  # Rolling updates and deployments
  setting {
    name      = "DeploymentPolicy"
    namespace = "aws:elasticbeanstalk:command"
    value     = "Rolling"
  }

  setting {
    name      = "BatchSizeType"
    namespace = "aws:elasticbeanstalk:command"
    value     = "Percentage"
  }

  setting {
    name      = "BatchSize"
    namespace = "aws:elasticbeanstalk:command"
    value     = 50
  }

  setting {
    name      = "RollingUpdateType"
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    value     = "Health"
  }

  # security
  setting {
    name      = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value     = var.service_role_arn
  }

  setting {
    name      = "EC2KeyName"
    namespace = "aws:autoscaling:launchconfiguration"
    value     =  var.key_name
  }

  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  # Notifications
  setting {
    name      = "NotificationEndpoint"
    namespace = "aws:elasticbeanstalk:sns:topics"
    value     = var.notification_endpoint_email
  }

  # Network
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnet_ids)
  }
}

