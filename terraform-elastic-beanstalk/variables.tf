variable "app_name" {
  type    = string
  default = "ExampleApp"
}

variable "TFE_VPC_ID" {
  type    = string
  sensitive = true
}

variable "TFE_SSH_IP" {
  type    = string
  default = ""
  sensitive = true
}

variable "TFE_PERSONAL_IP" {
  type    = string
  default = ""
  sensitive = true
}

variable TFE_CERTIFICATE_ARN {
  type = string
  default = ""
  sensitive = true
}

variable TFE_BEANSTALK_SERVICE_ARN {
  type = string
  default = ""
  sensitive = true
}