variable "name" {}

variable "region" {}

variable "environment" {}

variable "security_groups" {
  type = "list"
}

variable "subnets" {
  type = "list"
}

variable "listeners" {
  type = "list"
}

variable "idle_timeout" {
  default = 400
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 400
}

variable "healthy_threshold" {
  default = 10
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 5
}

variable "target" {}

variable "interval" {
  default = 30
}

variable "is_internal_load_balancer" {
  default = true
}

variable "logging_bucket" {
  description = "The S3 bucket to send access logs to"
  default     = "ring-it-elb-logs"
}
