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
        "iam:PutUserPolicy",
        "iam:CreateAccessKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
