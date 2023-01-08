
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