resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "${format("%s-%s", var.environment, var.name)}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = true
  ebs_optimized               = false
  associate_public_ip_address = true
  security_groups             = ["${var.security_groups}"]
  key_name                    = "${var.ssh_key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${aws_launch_configuration.launch_config.name}"
  desired_capacity     = "${var.desired_count}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  health_check_type         = "${var.healthcheck_type}"
  health_check_grace_period = "${var.healthcheck_grace_period}"
  load_balancers            = ["${var.load_balancer_name}"]

  depends_on = ["aws_launch_configuration.launch_config"]

  lifecycle {
    create_before_destroy = true
  }

  enabled_metrics = ["GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]

  tags = [
    {
      key                 = "Name"
      value               = "${var.name}"
      propagate_at_launch = true
    },
  ]
}
