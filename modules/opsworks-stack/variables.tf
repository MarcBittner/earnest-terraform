variable "stack_name" {
  description = "The name of the stack"
}

variable "full_name" {
  description = "The full name of the service"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "region" {
  description = "The region the stack is in"
}

variable "environment" {
  description = "The environment i.e. dev, qa, prod"
}

variable "chef_version" {
  description = "The version of Chef the service is deployed with"
}

variable "cookbooks_url" {
  description = "The cookbooks repository url"
}

variable "cookbooks_revision" {
  description = "The cookbooks branch being used i.e. master"
}

variable "default_subnet_id" {
  description = "The default subnet id"
}
