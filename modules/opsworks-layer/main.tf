variable "name" {
  description = "The name for the OpsWorks layer"
}

variable "short_name" {
  description = "The short name for the OpsWorks layer"
}

variable "stack_id" {
  description = "The stack id for the OpsWorks layer"
}

variable "custom_json" {
  description = "The custom json for the OpsWorks layer"
}

variable "use_ebs" {
  description = "Enable ebs optimized instances"
  default     = false
}

variable "security_groups" {
  description = "A list of security group IDs to trust"
  type        = "list"
}

variable "instance_shutdown_timeout" {
  description = "The time in seconds that OpsWorks will wait for Chef after triggering shutdown"
  default     = 120
}

variable "assign_elastic_ips" {
  description = "Enable auto assign elastic ips"
  default     = false
}

variable "assign_public_ips" {
  description = "Enable auto assign public ips"
  default     = false
}

variable "drain_elb" {
  description = "Enable connection draining on ELB"
  default     = true
}

variable "custom_setup_recipes" {
  description = "The custom setup recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_configure_recipes" {
  description = "The custom configure recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_deploy_recipes" {
  description = "The custom deploy recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_undeploy_recipes" {
  description = "The custom undeploy recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "custom_shutdown_recipes" {
  description = "The custom shutdown recipes for the OpsWorks layer"
  type        = "list"
  default     = []
}

variable "enabled" {
  default = 1
}

variable "logging_volume_size" {
  description = "Defaults to 20 GB"
  default     = 20
}

resource "aws_opsworks_custom_layer" "layer" {
  count                       = "${var.enabled}"
  name                        = "${var.name}"
  short_name                  = "${var.short_name}"
  stack_id                    = "${var.stack_id}"
  custom_json                 = "${var.custom_json}"
  use_ebs_optimized_instances = "${var.use_ebs}"
  instance_shutdown_timeout   = "${var.instance_shutdown_timeout}"
  auto_assign_elastic_ips     = "${var.assign_elastic_ips}"
  auto_assign_public_ips      = "${var.assign_public_ips}"
  drain_elb_on_shutdown       = "${var.drain_elb}"
  custom_security_group_ids   = ["${var.security_groups}"]
  custom_setup_recipes        = "${var.custom_setup_recipes}"
  custom_configure_recipes    = "${var.custom_configure_recipes}"
  custom_deploy_recipes       = "${var.custom_deploy_recipes}"
  custom_undeploy_recipes     = "${var.custom_undeploy_recipes}"
  custom_shutdown_recipes     = "${var.custom_shutdown_recipes}"

  ebs_volume {
    mount_point     = "/var/log"
    size            = "${var.logging_volume_size}"
    number_of_disks = 1
    raid_level      = "none"
    type            = "standard"
  }

  lifecycle {
    ignore_changes = [
      "elastic_load_balancer",
    ]
  }
}

output "id" {
  value = "${aws_opsworks_custom_layer.layer.*.id}"
}
