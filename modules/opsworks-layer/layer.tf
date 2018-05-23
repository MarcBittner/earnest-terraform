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

output "name" {
  value = "${aws_opsworks_custom_layer.layer.name}"
}
