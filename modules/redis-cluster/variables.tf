variable "vpc_id" {
  description = "The VPC ID to launch the cluster in"
}

variable "name" {
  description = "The name of the ElasticCache redis cluster"
}

variable "environment" {
  description = "dev, qa, prod, etc"
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

variable "subnet_group_name" {}

variable "node_type" {
  type = "map"
}

variable "node_count" {
  type = "map"
}

variable "maintenance_window" {
  default = "sun:05:00-sun:06:00"
}

variable "qualsys_sg_id" {
  description = "The Qualsys security group ID"
}
