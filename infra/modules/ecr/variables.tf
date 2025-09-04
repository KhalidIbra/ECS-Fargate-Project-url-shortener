variable "repo_name" {
  type = string
}

variable "image_tag_mutability" {
  type = string
}

variable "scan_on_push" {
  type = bool
}

variable "keep_last_images" {
  type = number
}

variable "untagged_expiration_days" {
  type = number
}