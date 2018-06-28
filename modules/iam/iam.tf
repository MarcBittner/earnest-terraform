resource "aws_iam_instance_profile" "default_instance_profile" {
  name_prefix = "${format("%s%sProfile", join("",split("-",var.name)), title(var.environment))}"
  role        = "${aws_iam_role.default_instance_role.name}"
}

resource "aws_iam_role" "default_instance_role" {
  name_prefix = "${format("%s%sRole", join("",split("-",var.name)), title(var.environment))}"

  assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name_prefix = "${format("%s%sRolePolicy", join("",split("-",var.name)), title(var.environment))}"
  role        = "${aws_iam_role.default_instance_role.id}"

  policy = "${var.role_policy}"
}
