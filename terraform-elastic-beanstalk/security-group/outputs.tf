output "vpc" {
  value = var.vpc_id
}

output "security_group" {
  value = aws_security_group.sg_load_balancer.name
}