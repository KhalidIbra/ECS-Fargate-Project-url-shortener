

#------------------------------- ECS -------------------------------
variable "service_name" {
  type        = string
  default = "ki-url-service"
}

variable "container_image" {
  type        = string
}

variable "container_port" {
  type        = number
  default     = 8080
}

variable "task_cpu" {
  type        = number
  default     = 256
}

variable "task_memory" {
  type        = number
  default     = 512
}

variable "desired_task_count" {
  type        = number
  default     = 2
}

variable "dynamodb_tablename" {
  type        = string
}

variable "region" {
  type        = string
  default     = "eu-west-1"
}

#----------------------- ECR ----------------------------------

variable "repo_name" {
  type = string
  default = "url-app-repo"
}

variable "image_tag_mutability" {
  type = string
  default = "IMMUTABLE"
}

variable "scan_on_push" {
  type = bool
  default = true
}

variable "keep_last_images" {
  type = number
  default = 10
}

variable "untagged_expiration_days" {
  type = number
  default = 14
}

#---------------------------------ALB-------------------------------

variable "app_port" {
type = number
default = 8080
}


#----------------------------------Networking-----------------------------

variable "vpc_cidr" {
  type        = string
}

variable "private_subnet_cidrs" {
  type        = list(string)
}

variable "azs" {
  type        = list(string)
}

variable "public_subnet_cidrs" {
  type        = list(string)
}

#----------------------------------CodeDeploy------------------------------

variable "name" { 
    type = string 
}

#---------------------------------IAM--------------------------------------

variable "github_repo" {
  type        = string
}

