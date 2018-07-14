// Get the access to the effective Account ID in which Terraform is working
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "splunk_user" {
  name = "security-splunk"
  path = "/system/"
}

resource "aws_iam_policy" "splunk-ro-policy" {
  name   = "splunk-ro-policy"
  policy = "${data.aws_iam_policy_document.aws_splunk_ro_policy.json}"
}

resource "aws_iam_policy_attachment" "splunk-ro-policy" {
  name       = "splunk-ro-policy"
  users      = ["${aws_iam_user.splunk_user.name}"]
  policy_arn = "${aws_iam_policy.splunk-ro-policy.arn}"
}

resource "aws_iam_policy" "splunk-sqs-policy" {
  name   = "splunk-sqs-policy"
  policy = "${data.aws_iam_policy_document.aws_sqs_policy.json}"
}

resource "aws_iam_policy_attachment" "splunk-sqs-policy" {
  name       = "splunk-sqs-policy"
  users      = ["${aws_iam_user.splunk_user.name}"]
  policy_arn = "${aws_iam_policy.splunk-sqs-policy.arn}"
}

data "aws_iam_policy_document" "aws_splunk_ro_policy" {
  statement {
    actions = ["sqs:GetQueueAttributes", "sqs:ListQueues", "sqs:GetQueueUrl", "s3:ListBucket", "s3:GetObject", "s3:GetBucketLocation", "s3:ListAllMyBuckets", "s3:GetBucketTagging", "s3:GetAccelerateConfiguration", "s3:GetBucketLogging", "s3:GetLifecycleConfiguration", "s3:GetBucketCORS", "config:DeliverConfigSnapshot", "config:DescribeConfigRules", "config:DescribeConfigRuleEvaluationStatus", "config:GetComplianceDetailsByConfigRule", "config:GetComplianceSummaryByConfigRule", "iam:GetUser", "iam:ListUsers", "iam:GetAccountPasswordPolicy", "iam:ListAccessKeys", "iam:GetAccessKeyLastUsed", "autoscaling:Describe*", "cloudwatch:Describe*", "cloudwatch:Get*", "cloudwatch:List*", "sns:Get*", "sns:List*", "sns:Publish", "logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:GetLogEvents", "ec2:DescribeInstances", "ec2:DescribeReservedInstances", "ec2:DescribeSnapshots", "ec2:DescribeRegions", "ec2:DescribeKeyPairs", "ec2:DescribeNetworkAcls", "ec2:DescribeSecurityGroups", "ec2:DescribeSubnets", "ec2:DescribeVolumes", "ec2:DescribeVpcs", "ec2:DescribeImages", "ec2:DescribeAddresses", "lambda:ListFunctions", "rds:DescribeDBInstances", "cloudfront:ListDistributions", "elasticloadbalancing:DescribeLoadBalancers", "elasticloadbalancing:DescribeInstanceHealth", "elasticloadbalancing:DescribeTags", "elasticloadbalancing:DescribeTargetGroups", "elasticloadbalancing:DescribeTargetHealth", "elasticloadbalancing:DescribeListeners", "inspector:Describe*", "inspector:List*", "kinesis:Get*", "kinesis:DescribeStream", "kinesis:ListStreams", "kms:Decrypt", "sts:AssumeRole", "cloudtrail:DescribeTrails", "cloudtrail:GetTrailStatus", "cloudtrail:ListPublicKeys", "cloudtrail:ListTags", "ec2:Describe*", "elasticloadbalancing:DescribeInstanceHealth", "elasticloadbalancing:DescribeListeners", "elasticloadbalancing:DescribeLoadBalancerAttributes", "elasticloadbalancing:DescribeLoadBalancerPolicyTypes", "elasticloadbalancing:DescribeLoadBalancerPolicies", "elasticloadbalancing:DescribeLoadBalancers", "elasticloadbalancing:DescribeRules", "elasticloadbalancing:DescribeSSLPolicies", "elasticloadbalancing:DescribeTags", "elasticloadbalancing:DescribeTargetGroupAttributes", "elasticloadbalancing:DescribeTargetGroups", "elasticloadbalancing:DescribeTargetHealth", "iam:GenerateCredentialReport", "iam:GetAccountPasswordPolicy", "iam:GetCredentialReport", "iam:GetAccountSummary", "iam:ListAttachedUserPolicies", "iam:ListUsers", "kms:GetKeyRotationStatus", "kms:ListKeys", "rds:DescribeAccountAttributes", "rds:DescribeCertificates", "rds:DescribeEngineDefaultClusterParameters", "rds:DescribeEngineDefaultParameters", "rds:DescribeDBClusterParameterGroups", "rds:DescribeDBClusterParameters", "rds:DescribeDBClusterSnapshots", "rds:DescribeDBClusters", "rds:DescribeDBInstances", "rds:DescribeDBLogFiles", "rds:DescribeDBParameterGroups", "rds:DescribeDBParameters", "rds:DescribeDBSecurityGroups", "rds:DescribeDBSnapshotAttributes", "rds:DescribeDBSnapshots", "rds:DescribeDBEngineVersions", "rds:DescribeDBSubnetGroups", "rds:DescribeEventCategories", "rds:DescribeEvents", "rds:DescribeEventSubscriptions", "rds:DescribeOptionGroups", "rds:DescribeOptionGroupOptions", "rds:DescribeOrderableDBInstanceOptions", "rds:DescribePendingMaintenanceActions", "rds:DescribeReservedDBInstances", "rds:DescribeReservedDBInstancesOfferings", "rds:ListTagsForResource", "s3:GetBucketAcl", "s3:GetBucketPolicy", "s3:ListAllMyBuckets", "s3:GetBucketLocation", "s3:GetBucketLogging", "sns:GetEndpointAttributes", "sns:GetPlatformApplicationAttributes", "sns:GetSMSAttributes", "sns:GetSubscriptionAttributes", "sns:GetTopicAttributes", "sns:ListEndpointsByPlatformApplication", "sns:ListPlatformApplications", "sns:ListSubscriptions", "sns:ListSubscriptionsByTopic", "sns:ListTopics"]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "aws_sqs_policy" {
  statement {
    actions = ["sqs:GetQueueAttributes", "sqs:GetQueueUrl", "sqs:DeleteMessage", "sqs:ListQueues", "sqs:ReceiveMessage"]

    resources = ["${aws_sqs_queue.splunk_cloudtrail_queue.arn}", "${aws_sqs_queue.splunk_cloudfront_queue.arn}", "${aws_sqs_queue.splunk_config_queue.arn}", "${aws_sqs_queue.splunk_elb_queue.arn}", "${aws_sqs_queue.splunk_s3access_queue.arn}"]
  }

  statement {
    actions = ["s3:Get", "s3:List"]

    resources = ["${aws_s3_bucket.splunk_s3.arn}/*"]
  }
}

# role for config
// Allows AWS Config IAM role to access the S3 bucket where AWS Config records
// are stored

data "aws_iam_policy_document" "splunk-role-policy" {
  statement {
    actions = ["s3:GetBucketAcl"]

    resources = ["${aws_s3_bucket.splunk_s3.arn}"]
  }

  statement {
    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.splunk_s3.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = ["bucket-owner-full-control"]
    }
  }

  statement {
    actions = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "logs:DescribeLogGroups", "logs:DescribeLogStreams"]

    resources = ["*"]
  }
}

// Allow IAM policy to assume the role for AWS Config
data "aws_iam_policy_document" "aws-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com", "vpc-flow-logs.amazonaws.com"]
    }

    effect = "Allow"
  }
}

/**
 * IAM Role
 */

resource "aws_iam_role" "splunk-role" {
  name = "splunk-role"

  assume_role_policy = "${data.aws_iam_policy_document.aws-assume-role-policy.json}"
}

resource "aws_iam_policy_attachment" "config-policy" {
  name       = "assume-splunk-config-policy"
  roles      = ["${aws_iam_role.splunk-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_iam_policy" "splunk-role-policy" {
  name   = "splunk-role-policy"
  policy = "${data.aws_iam_policy_document.splunk-role-policy.json}"
}

resource "aws_iam_policy_attachment" "splunk-role-policy" {
  name       = "splunk-role-policy"
  roles      = ["${aws_iam_role.splunk-role.name}"]
  policy_arn = "${aws_iam_policy.splunk-role-policy.arn}"
}
