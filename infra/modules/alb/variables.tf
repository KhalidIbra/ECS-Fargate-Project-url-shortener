variable "service_name" {
type = string
default = "ki-ecs-service"
}

variable "region" {
type = string
default = "eu-west-1"
}


variable "vpc_id" {
type = string
}

variable "security_group_id" {
type = string
}

variable "private_subnet_mappings" {
type = map(any)
}

variable "app_port" {
type = number
default = 8080
}

variable "waf_web_acl_arn" {
  type        = string
}

