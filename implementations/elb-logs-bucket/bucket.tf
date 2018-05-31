resource "aws_s3_bucket" "logging_bucket" {
  bucket = "ring-it-elb-logs"
  acl    = "private"

  tags {
    Name = "ring-it-elb-logs"
  }
}

resource "aws_s3_bucket" "ring_elb_logs" {
  bucket = "ring-it-elb-logs"
  acl    = "private"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Policy1459289025506",
  "Statement": [
    {
      "Sid": "AllowElbWrites",
      "Effect": "Allow",
      "Principal": {
          "AWS": "arn:aws:iam::127311923021:root",
          "AWS": "arn:aws:iam::033677994240:root",
          "AWS": "arn:aws:iam::027434742980:root",
          "AWS": "arn:aws:iam::797873946194:root",
          "AWS": "arn:aws:iam::985666609251:root",
          "AWS": "arn:aws:iam::054676820928:root",
          "AWS": "arn:aws:iam::156460612806:root",
          "AWS": "arn:aws:iam::652711504416:root",
          "AWS": "arn:aws:iam::009996457667:root",
          "AWS": "arn:aws:iam::582318560864:root",
          "AWS": "arn:aws:iam::600734575887:root",
          "AWS": "arn:aws:iam::383597477331:root",
          "AWS": "arn:aws:iam::114774131450:root",
          "AWS": "arn:aws:iam::783225319266:root",
          "AWS": "arn:aws:iam::718504428378:root",
          "AWS": "arn:aws:iam::507241528517:root"
      },
      "Action": [
          "s3:PutObject",
          "s3:PutObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::ring-it-elb-logs/*"
      ]
    }
  ]
}
POLICY
}
