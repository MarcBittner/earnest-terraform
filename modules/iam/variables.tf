variable "name" {
  description = "The service name"
}

variable "environment" {
  description = "The environment to be deployed to"
}

variable "role_policy" {
  description = "The policy to be attached to the role"
}

variable "assume_role_policy" {
  description = "The assume role policy to be attached to the role"
}
