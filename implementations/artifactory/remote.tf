data "terraform_remote_state" "vpc" {
  bucket = "slkdjfasldkf"
  path   = "env:/${terraform.workspace}/implementations/hub-vpcs"
}

aws_asg "artifactory" {
  subnet_ids = ["${data.terraform_remote_state.vpc.subnets.private.ids}"]
}
