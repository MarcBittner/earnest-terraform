locals {
  private_subnet_tags = {
    "kubernetes.io/role/private-subnet" = 1
  }

  public_subnet_tags = {
    "kubernetes.io/role/public-subnet" = 1
    "kubernetes.io/role/external-elb"  = 1
  }

  public_nat_subnet_tags = {
    "kubernetes.io/role/nat" = 1
  }

  private_elb_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  private_tooling_subnet_tags = {
    "kubernetes.io/role/tooling-subnet" = 1
  }

  fortknox_subnet_tags = {
    "kubernetes.io/role/fortknox-subnet" = 1
  }

  #This leaves an additional ~9,900 ip addresses within the vpc 
  private_subnets_block         = "${var.cidr_base}.0.0/17"
  public_subnets_block          = "${var.cidr_base}.128.0/18"
  fortknox_subnets_block        = "${var.cidr_base}.192.0/20"
  private_elb_subnets_block     = "${var.cidr_base}.212.0/22"
  private_tooling_subnets_block = "${var.cidr_base}.208.0/22"
  public_nat_subnets_block      = "${var.cidr_base}.216.0/23"
}

################
# Public subnets
################
resource "aws_subnet" "public" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.public_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "true"
  tags                    = "${merge(local.public_subnet_tags, var.public_subnet_tags, map("Name", "${var.name}-public-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################

output "subnets.public.ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "subnets.public.availability_zones" {
  value = ["${aws_subnet.public.*.availability_zone}"]
}

################
# Public nat subnets
################
resource "aws_subnet" "public_nat" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.public_nat_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "true"
  tags                    = "${merge(local.public_nat_subnet_tags, var.public_nat_subnet_tags, map("Name", "${var.name}-public-nat-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################

output "subnets.public_nat.ids" {
  value = ["${aws_subnet.public_nat.*.id}"]
}

output "subnets.public_nat.availability_zones" {
  value = ["${aws_subnet.public_nat.*.availability_zone}"]
}

#################
# Private subnets
#################
resource "aws_subnet" "private" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.private_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "false"
  tags                    = "${merge(local.private_subnet_tags, var.private_subnet_tags, map("Name", "${var.name}-private-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################
output "subnets.private.ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "subnets.private.availability_zones" {
  value = ["${aws_subnet.private.*.availability_zone}"]
}

#################
# Private ELB subnets
#################
resource "aws_subnet" "private_elb" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.private_elb_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "false"
  tags                    = "${merge(local.private_elb_subnet_tags, var.private_elb_subnet_tags, map("Name", "${var.name}-private-elb-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################
output "subnets.private_elb.ids" {
  value = ["${aws_subnet.private_elb.*.id}"]
}

output "subnets.private_elb.availability_zones" {
  value = ["${aws_subnet.private_elb.*.availability_zone}"]
}

#################
# Private tooling subnets
#################
resource "aws_subnet" "private_tooling" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.private_tooling_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "false"
  tags                    = "${merge(local.private_tooling_subnet_tags, var.private_tooling_subnet_tags, map("Name", "${var.name}-private-tooling-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################
output "subnets.private_tooling.ids" {
  value = ["${aws_subnet.private_tooling.*.id}"]
}

output "subnets.private_tooling.availability_zones" {
  value = ["${aws_subnet.private_tooling.*.availability_zone}"]
}

##################
# Fort Knox subnets
##################
resource "aws_subnet" "fortknox" {
  count      = "${var.region-az-count-mapping[var.region]}"
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "${cidrsubnet(local.fortknox_subnets_block, ceil(pow(var.region-az-count-mapping[var.region],0.5)), count.index)}"

  availability_zone       = "${var.region}${var.number-to-letter-mapping[count.index]}"
  map_public_ip_on_launch = "false"
  tags                    = "${merge(local.fortknox_subnet_tags, var.fortknox_subnet_tags, map("Name", "${var.name}-fortknox-${var.number-to-letter-mapping[count.index]}"))}"
}

#outputs
################
output "subnets.fortknox.ids" {
  value = ["${aws_subnet.fortknox.*.id}"]
}

output "subnets.fortknox.availability_zones" {
  value = ["${aws_subnet.fortknox.*.availability_zone}"]
}

###################
# RDS Subnet Groups
###################

resource "aws_db_subnet_group" "fortknox_database" {
  name        = "${var.name}_fortknox_database"
  description = "${var.name} fortknox db subnet group"

  subnet_ids = ["${aws_subnet.fortknox.*.id}"]
}

resource "aws_db_subnet_group" "private_database" {
  name        = "${var.name}_private_database"
  description = "${var.name} private db subnet group"

  subnet_ids = ["${aws_subnet.private.*.id}"]
}

output "aws_db_subnet_group.private_database.id" {
  value = "${aws_db_subnet_group.private_database.id}"
}

###################
# Elasticache Subnet Groups
###################

resource "aws_elasticache_subnet_group" "fortknox_elasticache" {
  name        = "${var.name}_fortknox_elasticache"
  description = "${var.name} fortknox elasticache subnet group"

  subnet_ids = ["${aws_subnet.fortknox.*.id}"]
}

output "aws_elasticache_subnet_group.fortknox_elasticache.id" {
  value = "${aws_elasticache_subnet_group.fortknox_elasticache.id}"
}

resource "aws_elasticache_subnet_group" "private_elasticache" {
  name        = "${var.name}_private_elasticache"
  description = "${var.name} private elasticache subnet group"

  subnet_ids = ["${aws_subnet.private.*.id}"]
}

output "aws_elasticache_subnet_group.private_elasticache.id" {
  value = "${aws_elasticache_subnet_group.private_elasticache.id}"
}
