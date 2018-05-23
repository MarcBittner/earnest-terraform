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

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.name}"
  engine               = "redis"
  engine_version       = "${var.engine_version}"
  maintenance_window   = "${var.maintenance_window}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "1"
  parameter_group_name = "${var.parameter_group_name}"
  port                 = "6379"
  subnet_group_name    = "${vpc.aws_elasticache_subnet_group.fortknox_elasticache.id}"
  security_group_ids   = ["${aws_security_group.redis.id}"]
  apply_immediately    = true

  tags {
    Name = "${var.name}"
  }
}
