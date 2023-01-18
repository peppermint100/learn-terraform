variable "app_name" {
    type = string
}

variable "sg_load_balancer_id" {
    type = string
}

variable "certificate_arn" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "target_group_arn" {
    type = string
}