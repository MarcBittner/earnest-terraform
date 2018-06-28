resource "aws_iam_instance_profile" "default_instance_profile" {
  name_prefix = "${substr(format("%s%sProfile", join("",split("-",var.name)), title(var.environment)), 0, 32)}"
  role        = "${aws_iam_role.default_instance_role.name}"
}

resource "aws_iam_role" "default_instance_role" {
  name_prefix = "${substr(format("%s%sRole", join("",split("-",var.name)), title(var.environment)), 0 ,32)}"

  assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name_prefix = "${substr(format("%s%sRolePolicy", join("",split("-",var.name)), title(var.environment)), 0, 32)}"
  role        = "${aws_iam_role.default_instance_role.id}"

  policy = "${var.role_policy}"
}
