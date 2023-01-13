output "sg_load_balancer_id" {
    value = aws_security_group.sg_load_balancer.id
}

output "sg_instance_id" {
    value = aws_security_group.sg_instance.id
}