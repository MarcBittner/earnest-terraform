resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "${var.name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = true
  ebs_optimized               = false
  associate_public_ip_address = true
  security_groups             = ["${var.security_groups}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${aws_launch_configuration.launch_config.name}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  depends_on = ["aws_launch_configuration.launch_config"]

  tags = [
    {
      key                 = "project_name"
      value               = "${var.name}"
      propagate_at_launch = true
    },
  ]
}
