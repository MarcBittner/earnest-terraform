data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh.tmpl")}"

  vars {
    file_name   = "Ring-Spot-latest.tar.gz"
    bucket_name = "ring-asg-script"
  }
}

resource "aws_launch_configuration" "launch_config" {
  count                       = "${var.enabled}"
  name_prefix                 = "lc-${var.name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  user_data                   = "${data.template_file.user_data.rendered}"
  enable_monitoring           = true
  ebs_optimized               = false
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  count                = "${var.enabled}"
  name                 = "asg-${var.name}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  launch_configuration = "${aws_launch_configuration.launch_config.name}"
  vpc_zone_identifier  = ["${var.subnets}"]

  depends_on = ["aws_launch_configuration.launch_config"]

  tags = [
    {
      key                 = "opsworks:layer"
      value               = "${var.name}"
      propagate_at_launch = true
    },
    {
      key                 = "opsworks:stack"
      value               = "${var.stack_name}"
      propagate_at_launch = true
    },
  ]
}
