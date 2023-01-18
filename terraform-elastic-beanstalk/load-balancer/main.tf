resource "aws_lb" "shared_load_balancer" {
  name               = "alb-${var.app_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_load_balancer_id]
  enable_deletion_protection = false
  subnets = var.subnet_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.shared_load_balancer.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.shared_load_balancer.arn
  port = "443"
  protocol = "HTTPS" 
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}