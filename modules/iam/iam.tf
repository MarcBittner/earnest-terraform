resource "aws_iam_instance_profile" "default_instance_profile" {
  name_prefix = "${format("%s-%s-profile", var.name, var.environment)}"
  role        = "${aws_iam_role.default_instance_role.name}"
}

resource "aws_iam_role" "default_instance_role" {
  name_prefix = "${format("%s-%s-role", var.name, var.environment)}"

  assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name_prefix = "${format("%s-%s-role-policy", var.name, var.environment)}"
  role        = "${aws_iam_role.default_instance_role.id}"

  policy = "${var.role_policy}"
}
