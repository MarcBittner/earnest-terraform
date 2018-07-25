variable "name" {
  description = "The project name"
}

variable "environment" {
  description = "The environment the ASG is in"
}

variable "image_id" {
  description = "The AMI Id for the launch configuration"
}

variable "user_data" {
  description = "The user data for the launch configuration"
}

variable "instance_type" {
  description = "The AWS instance type the service should be created with i.e. c5.large"
}

variable "iam_instance_profile" {
  description = "The IAM role the instance should assume"
}

variable "max_size" {
  description = "ASG max instance count"
  default     = 1
}

variable "min_size" {
  description = "ASG min instance count"
  default     = 1
}

variable "desired_count" {
  description = "ASG desired instance count"
  default     = 1
}

variable "subnets" {
  description = "List of subnets for ASG"
  type        = "list"
}

variable "security_groups" {
  description = "The IDs of the security groups to attach to the ASG launch configuration"
  type        = "list"
  default     = []
}

variable "ssh_key_name" {
  description = "The ssh key name for the private key to ssh into ASG instances"
  default     = ""
}

variable "healthcheck_type" {
  description = "Either ELB or EC2"
  default     = "EC2"
}

variable "healthcheck_grace_period" {
  description = "Time it takes after instance spins up before checking health"
  default     = 180
}

variable "load_balancer_name" {
  description = "Name of load balancer to assign to the ASG"
  default     = ""
}
