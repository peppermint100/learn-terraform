variable "app_name" {
  type    = string
  default = "ExampleApp"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0e181d8b25792b0b1"
}

variable "TFC_SSH_IP" {
  type = string
  default = ""
}

variable "TFC_PERSONAL_IP" {
  type = string
  default = ""
}