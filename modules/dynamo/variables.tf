variable "name" {
  description = "The name of the dynamo db table"
}

variable "environment" {
  description = "The current environment i.e. dev, qa, prod, etc"
}

variable "read_capacity" {
  description = "The read capacity of the dynamo db table"
  default     = 5
}

variable "write_capacity" {
  description = "The write capacity of the dynamo db table"
  default     = 5
}

variable "hash_key" {
  description = "The partition key that is used to partition data"
}

variable "hash_key_type" {
  description = "The type of the partition key (S, N, or B)"
  default     = "S"
}

variable "range_key" {
  description = "The sort key used for searching within a partition"
}

variable "range_key_type" {
  description = "The type of the sort key (S, N, or B)"
  default     = "S"
}

variable "enable_encryption" {
  description = "Whether encryption is enabled"
  default     = false
}

variable "additional_attributes" {
  type        = "list"
  description = "List of additional table attributes and their types"
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
  description = "List of global secondary indexes"
  default     = []
}

variable "local_secondary_indexes" {
  type        = "list"
  description = "List of local secondary indexes"
  default     = []
}

variable "tags" {
  type        = "map"
  description = "Map of tags for the table"
  default     = {}
}
