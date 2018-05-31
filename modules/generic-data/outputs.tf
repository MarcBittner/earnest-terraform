output "environment-profile-mapping" {
  value = "${var.environment-profile-mapping}"
}

output "environment-region-mapping" {
  value = "${var.environment-region-mapping}"
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
