variable "vpc_id" {
  description = "The VPC ID to launch the cluster in"
}

variable "name" {
  description = "The name of the ElasticCache redis cluster"
}

variable "engine_version" {
  default = "3.2.10"
}

variable "parameter_group_name" {
  default = "default.redis3.2.cluster.on"
}

variable "number_of_shards" {
  default = "3"
}

variable "replicas_per_shard" {
  default = "2"
}

variable "private_subnet_ids" {
  description = "A comma-seperated list of subnets to launch the cluster in"
}

variable "node_type" {
  default = "cache.m3.medium"
}

variable "parameter_group_name" {
  default = "default.redis3.2.cluster.on"
}

variable "maintenance_window" {
  default = "sun:05:00-sun:06:00"
}

variable "qualsys_sg_id" {
  description = "The Qualsys security group ID"
}
