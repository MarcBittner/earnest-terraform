resource "aws_security_group" "redis" {
  name = "${var.name}"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port       = "6379"
    to_port         = "6379"
    protocol        = "tcp"
    security_groups = ["${var.qualsys_sg_id}"]
  }

  ingress {
    from_port = "6379"
    to_port   = "6379"
    protocol  = "tcp"
    self      = true
  }

  tags {
    Name = "${var.name}"
  }
}

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
