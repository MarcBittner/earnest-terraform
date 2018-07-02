resource "aws_s3_bucket" "ring-distributions" {
  bucket = "ring-distributions"
  acl    = "private"

  versioning {
    enabled = true
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowReadsToDevAndProdAccounts",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::613225557329:root",
          "arn:aws:iam::890452240102:root"
        ]
      },
      "Action": [
        "s3:GetObject",
        "s3:GetObjectAcl"
      ],
      "Resource": [
        "arn:aws:s3:::ring-distributions/*"
      ]
    }
  ]
}
POLICY

  tags {
    Name = "ring-distributions"
  }
}
