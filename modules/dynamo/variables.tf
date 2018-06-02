variable "name" {
  description = "The name of the dynamo db table"
}

variable "environment" {
  description = "The current environment i.e. dev, qa, prod, etc"
}

variable "read_capacity" {
  description = "The read capacity of the dynamo db table"
}

variable "write_capacity" {
  description = "The write capacity of the dynamo db table"
}

variable "hash_key" {
  description = "The partition key that is used to partition data"
}

variable "range_key" {
  description = "The sort key used for searching within a partition"
}

variable "enable_encryption" {
  description = "Whether encryption is enabled"
  default     = false
}

variable "additional_attributes" {
  description = "List of additional table attributes and their types"
  type        = "list"
  default     = []
}

variable "ttl_attribute_name" {
  description = "The attribute_name used for the TTL i.e. created_at"
  default     = ""
}

variable "ttl_enabled" {
  description = "Whether the ttl is enabled"
  default     = false
}

variable "global_secondary_indexes" {
  type        = "list"
  default     = []
  description = "List of global secondary indexes"
}

variable "local_secondary_indexes" {
  type        = "list"
  default     = []
  description = "List of local secondary indexes"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Map of tags for the table"
}
