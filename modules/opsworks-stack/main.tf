variable "stack_name" {
  description = "The name of the stack"
}

variable "full_name" {
  description = "The full name of the service"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "region" {
  description = "The region the stack is in"
}

variable "environment" {
  description = "The environment i.e. dev, qa, prod"
}

variable "chef_version" {
  description = "The version of Chef the service is deployed with"
}

variable "cookbooks_url" {
  description = "The cookbooks repository url"
}

variable "cookbooks_revision" {
  description = "The cookbooks branch being used i.e. master"
}

variable "custom_json" {
  description = "The stack's custom json"
}

variable "default_subnet_id" {
  description = "The default subnet id"
}

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

  custom_json = "${var.custom_json}"
}

resource "aws_iam_role" "stack_role" {
  name_prefix = "${format("%s%sStackRole", join("",split(" ",var.full_name)), title(var.environment))}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "opsworks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "default_stack_role_policy" {
  name_prefix = "${format("%s%sStackRolePolicy", join("",split(" ",var.full_name)), title(var.environment))}"
  role        = "${aws_iam_role.stack_role.id}"

  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
          "ec2:*",
          "iam:PassRole",
          "elasticloadbalancing:*",
          "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
          "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "default_instance_profile" {
  name_prefix = "${substr(format("%s%sInstanceProfile", join("",split(" ",var.full_name)), title(var.environment)), 0, 32)}"
  role        = "${aws_iam_role.default_instance_role.name}"
}

resource "aws_iam_role" "default_instance_role" {
  name_prefix = "${substr(format("%s%sInstanceRole", join("",split(" ",var.full_name)), title(var.environment)), 0 ,32)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "instance_role_policy" {
  name_prefix = "${substr(format("%s%sInstanceRolePolicy", join("",split(" ",var.full_name)), title(var.environment)), 0, 32)}"
  role        = "${aws_iam_role.default_instance_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::ring-asg-script/*"
    },
    {
      "Action": [
        "ec2:DescribeTags"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "opsworks:DescribeStacks",
        "opsworks:DescribeLayers",
        "opsworks:DescribeInstances",
        "opsworks:RegisterInstance",
        "opsworks:AssignInstance",
        "opsworks:DescribeStackProvisioningParameters",
        "ec2:DescribeTags",
        "ec2:CreateTags",
        "iam:CreateGroup",
        "iam:CreateUser",
        "iam:AddUserToGroup",
        "iam:PutUserPolicy"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
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
