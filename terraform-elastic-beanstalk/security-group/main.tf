resource "aws_security_group" "sg_load_balancer" {
  vpc_id = var.vpc_id
  name = "alb-${var.app_name}-sg"
  description = "SG for load balancer"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

//resource "aws_security_group" "sg_instance" {
//  vpc_id = var.vpc_id
//  name = "instance-${var.app_name}-sg"
//  description = "SG for Instance"
//  ingress {
//    from_port = 22
//    to_port = 22
//    protocol = "tcp"
//    cidr_blocks = [var.ssh_ip]
//  }
//  ingress {
//    from_port = 80
//    to_port = 80
//    protocol = "tcp"
//    security_groups = [aws_security_group.sg_load_balancer.id]
//  }
//  egress {
//    from_port       = 0
//    to_port         = 0
//    protocol        = "-1"
//    cidr_blocks     = ["0.0.0.0/0"]
//  }
//}