variable "service_name" {
    type = string
    default = "ki-ecs-service"
}

variable "container_image" {
    type = string
    default = ""
}

variable "task_cpu" {
    type = number
    default = "512"
}

variable "task_memory" {
    type = number
    default = "1024"
}

variable "container_port" {
    type = number
    default = "8080"
}

variable "desired_task_count" {
    type =number
    default = 0
}

variable "subnets" {
    type =list(string)
}

variable "security_groups" {
    type =list(string)
}

variable "alb_target_group_arn" {
    type =string
}

variable "execution_role_arn" {
    type = string
}

variable "task_role_arn" { 
    type = string 
}

variable "dynamodb_tablename" { 
    type = string 
}
