resource "aws_alb_target_group" "load_balancer" {
  name                = "tg-${var.app_name}"
  port                = "80"
  protocol            = "HTTP"
  target_type         = "instance"
  vpc_id = var.vpc_id
}