output "environment-profile-mapping" {
  value = "${var.environment-profile-mapping}"
}

output "environment-region-mapping" {
  value = "${var.environment-region-mapping}"
}

output "environment-account-mapping" {
  value = "${var.environment-account-mapping}"
}

output "environment-short-to-long-name-mapping" {
  value = "${var.environment-short-to-long-name-mapping}"
}

output "env" {
  value = "${element(split("-", terraform.workspace), 0)}"
}

output "region" {
  value = "${join("-", slice(split("-", terraform.workspace), 1, length(split("-", terraform.workspace))))}"
}

output "region-elb-account-mapping" {
  value = "${var.region-elb-account-mapping}"
}

output "elb-logs-bucket" {
  value = "${var.elb-logs-bucket}"
}

output "region-az-count-mapping" {
  value = "${var.region-az-count-mapping}"
}

output "number-to-letter-mapping" {
  value = "${var.number-to-letter-mapping}"
}

output "environment-vpc-id-mapping" {
  value = "${var.environment-vpc-id-mapping}"
}

output "vpc-id-cidr-base-mapping" {
  value = "${var.vpc-id-cidr-base-mapping}"
}

output "env-to-ssl-cert-arn-mapping" {
  value = "${var.env-to-ssl-cert-arn-mapping}"
}

output "env-to-dns-suffix-mapping" {
  value = "${var.env-to-dns-suffix-mapping}"
}

output "env-to-dns-hosted-zone-mapping" {
  value = "${var.env-to-dns-hosted-zone-mapping}"
}
