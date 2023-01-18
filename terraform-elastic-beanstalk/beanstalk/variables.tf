variable "app_name" {
  type = string
}

variable "service_role_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "ami_id" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "security_groups" {
    type = list(string)
}

variable "health_check_path" {
    type = string
}

variable "key_name" {
  type = string
}

variable "notification_endpoint_email" {
  type = string
}

variable "load_balancer_arn" {
  type = string
}

