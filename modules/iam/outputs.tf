output "role_arn" {
  value = "${aws_iam_role.default_instance_role.arn}"
}

output "instance_profile_arn" {
  value = "${aws_iam_instance_profile.default_instance_profile.arn}"
}
