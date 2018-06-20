data "aws_ssm_parameter" "cookbooks_key" {
  name = "/Terraform/OpsWorks/ring-cookbooks-${var.chef_version}"
}

resource "aws_opsworks_stack" "stack" {
  name                          = "${format("%s-%s", var.stack_name, var.environment)}"
  region                        = "${var.region}"
  service_role_arn              = "${aws_iam_role.stack_role.arn}"
  default_instance_profile_arn  = "${aws_iam_instance_profile.default_instance_profile.arn}"
  vpc_id                        = "${var.vpc_id}"
  default_subnet_id             = "${var.default_subnet_id}"
  default_os                    = "Custom"
  configuration_manager_version = "${var.chef_version}"
  color                         = "rgb(111, 86, 163)"
  use_custom_cookbooks          = true
  use_opsworks_security_groups  = true

  custom_cookbooks_source {
    type     = "git"
    url      = "${var.cookbooks_url}"
    ssh_key  = "${trimspace(base64decode(data.aws_ssm_parameter.cookbooks_key.value))}"
    revision = "${var.cookbooks_revision}"
  }

  tags {
    Name    = "${var.full_name}"
    Env     = "${var.environment}"
    Project = "${var.stack_name}"
  }

  lifecycle {
    ignore_changes = ["custom_json"]
  }
}

output "stack_name" {
  value = "${aws_opsworks_stack.stack.name}"
}

output "stack_id" {
  value = "${aws_opsworks_stack.stack.id}"
}

output "default_instance_profile" {
  value = "${aws_iam_instance_profile.default_instance_profile.name}"
}
