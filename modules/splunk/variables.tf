variable "aws_account_name" {
  description = "Name of aws account"
  type        = "string"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = "string"
}

# config variable
variable "config_max_execution_frequency" {
  description = "The maximum frequency with which AWS Config runs evaluations for a rule."
  default     = "TwentyFour_Hours"
  type        = "string"
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = "string"
}

// Define the common tags for all resources
locals {
  common_tags = {
    Team    = "security"
    Purpose = "splunk-security"
    Project = "splunk"
  }
}

variable "vpc_ids" {
  description = "List of VPCs ID that you want flow log enabled for."
  type        = "list"
}
