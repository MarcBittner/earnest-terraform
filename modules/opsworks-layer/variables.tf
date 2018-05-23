variable "name" {
  description = "The name for the OpsWorks layer"
}

variable "enabled" {
  default = 1
}

# Layer variables
variable "short_name" {
  description = "The short name for the OpsWorks layer"
}

variable "stack_id" {
  description = "The stack id for the OpsWorks layer"
}

variable "custom_json" {
  description = "The custom json for the OpsWorks layer"
}

variable "use_ebs" {
  description = "Enable ebs optimized instances"
  default     = false
}

variable "security_groups" {
  description = "A list of security group IDs to trust"
  type        = "list"
}

variable "instance_shutdown_timeout" {
  description = "The time in seconds that OpsWorks will wait for Chef after triggering shutdown"
  default     = 120
}

variable "assign_elastic_ips" {
  description = "Enable auto assign elastic ips"
  default     = false
}

variable "assign_public_ips" {
  description = "Enable auto assign public ips"
  default     = false
}

variable "drain_elb" {
  description = "Enable connection draining on ELB"
  default     = true
}

variable "custom_setup_recipes" {
  description = "The custom setup recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_configure_recipes" {
  description = "The custom configure recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_deploy_recipes" {
  description = "The custom deploy recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_undeploy_recipes" {
  description = "The custom undeploy recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_shutdown_recipes" {
  description = "The custom shutdown recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "logging_volume_size" {
  description = "Defaults to 20 GB"
  default     = 20
}

# ASG variables
variable "image_id" {
  description = "The AMI Id for the launch configuration"
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

# FIXME: Remove (only use for debugging)
variable "key_name" {
  description = "Key name for Launch config"
  default     = ""
}

variable "stack_name" {
  description = "Name of stack the ASG layer belongs to"
}
