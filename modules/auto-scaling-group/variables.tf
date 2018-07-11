variable "name" {
  description = "The project name"
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
