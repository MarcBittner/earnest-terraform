resource "aws_security_group" "redis" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.name}"
  }
}

# resource "aws_elasticache_subnet_group" "default" {
#   name        = "subnet-group-${var.name}"
#   description = "Private subnets for ElastiCache instances"
#   subnet_ids  = ["${split(",", var.private_subnet_ids)}"]
# }

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.name}"
  replication_group_description = "${var.name}-redis-cluster"
  engine                        = "redis"
  engine_version                = "${var.engine_version}"
  maintenance_window            = "${var.maintenance_window}"
  automatic_failover_enabled    = true

  cluster_mode {
    replicas_per_node_group = 2
    num_node_groups         = "${var.node_count[var.environment]}"
  }

  node_type            = "${var.node_type[var.environment]}"
  parameter_group_name = "${var.parameter_group_name}"
  port                 = "6379"
  subnet_group_name    = "${var.subnet_group_name}"
  security_group_ids   = ["${aws_security_group.redis.id}"]
  apply_immediately    = true

  tags {
    Name = "${var.name}"
  }
}
