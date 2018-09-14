variable "splunk_admin_password" {}

variable "splunk_secret" {}

variable "splunk_download_url" {
  default = "https://www.splunk.com/page/download_track?file=7.1.2/linux/splunk-7.1.2-a0c72a66db66-linux-2.6-amd64.deb\\&ac=\\&wget=true\\&name=wget\\&platform=Linux\\&architecture=x86_64\\&version=7.1.2\\&product=splunk\\&typed=release"
}

variable "num_idx_instances" {
  type = "map"

  default = {
    "default"  = 25
    "security" = 10
  }
}

variable "num_hf_instances" {
  type = "map"

  default = {
    "default"  = 5
    "security" = 2
  }
}

variable "num_p_hf_instances" {
  type = "map"

  default = {
    "default"  = 2
    "security" = 1
  }
}

variable "key_name" {
  type = "map"

  default = {
    "default"  = "splunk"
    "security" = "sec-general"
  }
}

variable "local_domain" {
  default = "ring.local"
}

variable "root_storage" {
  default = 200
}

variable "idx_hot_storage" {
  default = 3400
}

variable "idx_cold_storage" {
  default = 10100
}

#ensure storage does not get deleted for prod
variable "idx_storage_delete" {
  type = "map"

  default = {
    "default"  = false
    "security" = true
  }
}

/* Per Region Lookup */
variable "idx_ami" {
  default = "ami-da05a4a0"
}

variable "idx_instance" {
  type = "map"

  default = {
    "default"  = "c4.4xlarge"
    "security" = "c4.2xlarge"
  }
}

variable "hfwd_ami" {
  default = "ami-da05a4a0"
}

variable "hfwd_instance" {
  type = "map"

  default = {
    "default"  = "c4.2xlarge"
    "security" = "c4.xlarge"
  }
}

variable "p_hfwd_instance" {
  type = "map"

  default = {
    "default"  = "c4.8xlarge"
    "security" = "c4.2xlarge"
  }
}

variable "rs-sh_instance" {
  type = "map"

  default = {
    "default"  = "c4.8xlarge"
    "security" = "c4.2xlarge"
  }
}

variable "sh_ami" {
  default = "ami-da05a4a0"
}

variable "sh_instance" {
  type = "map"

  default = {
    "default"  = "c4.2xlarge"
    "security" = "c4.large"
  }
}

variable "es_ami" {
  default = "ami-da05a4a0"
}

variable "es_instance" {
  type = "map"

  default = {
    "default"  = "c4.4xlarge"
    "security" = "c4.2xlarge"
  }
}

variable "ds_ami" {
  default = "ami-da05a4a0"
}

variable "ds_instance" {
  type = "map"

  default = {
    "default"  = "c4.2xlarge"
    "security" = "c4.large"
  }
}

variable "cm_ami" {
  default = "ami-da05a4a0"
}

variable "cm_instance" {
  type = "map"

  default = {
    "default"  = "c4.2xlarge"
    "security" = "c4.large"
  }
}

/* NETWORK */
variable "splunk_vpc_cidr" {
  default = "10.101.0.0/16"
}

variable "splunk_pub_subnet_b_cidr" {
  default = "10.101.4.0/26"
}

variable "splunk_pub_subnet_a_cidr" {
  default = "10.101.4.64/26"
}

variable "splunk_pub_subnet_c_cidr" {
  default = "10.101.4.128/26"
}

variable "lax16_cidr" {
  default = "72.21.198.0/24"
}

// SM Office 1
variable "sm_office_one" {
  default = "108.60.40.162/32"
}

// SM Office 2
variable "sm_office_two" {
  default = "108.60.47.166/32"
}

// Brett Home IP <- brett.bergin@ring.com
variable "brett_home" {
  default = "174.135.66.101/32"
}

// Bryan Home IP <- splunk consultant. temp. delete after 6/1/2018.
variable "bryan_home" {
  default = "209.222.12.139/32"
}

// Cylance Ingress Hosts.
variable "cylance_ingress_hosts" {
  default = ["13.113.53.36/32", "13.113.60.117/32", "52.63.15.218/32", "52.65.4.232/32", "52.2.154.63/32", "52.20.244.157/32", "52.71.59.248/32", "52.72.144.44/32", "54.88.241.49/32", "52.28.219.170/32", "52.29.102.181/32", "52.29.213.11/32"]
}

// Meraki Ingest Endpoints
variable "meraki_endpoints" {
  type    = "list"
  default = ["72.214.214.22/32", "66.210.240.21/32", "108.60.47.162/32", "108.60.47.166/32", "35.168.255.60/32", "166.170.5.130/32"]
}

/* OFFICE IP 1 | OFFICE IP 2 | BRETT HOME IP | BRYAN-SPLUNK HOME IP | Jon Home IP */
variable "static_ip_list" {
  type    = "list"
  default = ["108.60.40.162/32", "108.60.47.166/32", "174.135.66.101/32", "209.222.12.139/32", "172.113.63.64/32"]
}

variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["us-east-1b", "us-east-1c", "us-east-1f"]
}

variable "acm_arn" {
  type = "map"

  default = {
    "default"  = "arn:aws:acm:us-east-1:477418625794:certificate/5b59b7f1-014f-4ce5-bfbc-8ae9e7174efd"
    "security" = "arn:aws:acm:us-east-1:239226036377:certificate/2bde667e-3932-4bb4-b774-708c2ef6bbfc"
  }
}

variable "public_zone_id" {
  type = "map"

  default = {
    "default"  = "Z1PVCUSJYPB0KI"
    "security" = "Z2VRP1KZ874EW8"
  }
}

// Dont change this tag. We are using it to correlate something, but need to find out what.
// look for any subnet with matching vpc_id and tag=ha-pub
data "aws_subnet_ids" "az_subnets" {
  vpc_id = "${aws_vpc.splunk_vpc.id}"

  tags {
    type = "ha-pub"
  }

  //depends_on = ["aws_subnet.public_subnet_a","aws_subnet.public_subnet_b","aws_subnet.public_subnet_c"]
}

data "aws_subnet" "az_subnets" {
  count = 3                                                    //"${length(data.aws_subnet_ids.az_subnets.ids)}"
  id    = "${data.aws_subnet_ids.az_subnets.ids[count.index]}"

  // depends_on = ["data.aws_subnet_ids.az_subnets"]
}

// Define the common tags for all resources
locals {
  common_tags = {
    Team      = "security"
    Purpose   = "data-analytics"
    Project   = "splunk"
    Workspace = "${terraform.workspace}"
  }
}

// phantom_ingress_hosts
variable "phantom_ingress_hosts" {
  default = ["54.89.115.155/32"]
}

// mykyta drapatyi: Kiev office Remove this if needed
variable "mykyta_ingress_hosts" {
  default = ["217.20.170.129/32"]
}
