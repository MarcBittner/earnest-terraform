#Instance
resource "aws_instance" "meraki_vmx" {
  ami                    = "ami-bd50c8ab"
  vpc_security_group_ids = ["${data.terraform_remote_state.vpc.aws_security_group.allow_all.id}"]
  instance_type          = "m4.large"
  subnet_id              = "${data.terraform_remote_state.vpc.subnets.public.ids[2]}"
  user_data              = "${var.aws_user_data["${terraform.workspace}"]}"
  source_dest_check      = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags {
    Name         = "meraki-vmx"
    stack        = "meraki-vmx"
    Environment  = "${terraform.workspace}"
    businessUnit = "infrastructure"
  }
}

##Elastic IP Address
resource "aws_eip" "meraki_vmx_eip" {
  instance = "${aws_instance.meraki_vmx.id}"
  vpc      = true
}

#############################################
# Local Routes
#############################################

resource "aws_route" "public_vmx" {
  route_table_id            = "${data.terraform_remote_state.vpc.aws_route_table.public.id}"
  destination_cidr_block    = "10.0.0.0/8"
  instance_id = "${aws_instance.meraki_vmx.id}"
}

resource "aws_route" "private_vmx" {
  count = "${module.generic-data.region-az-count-mapping[local.region]}"

  route_table_id            = "${data.terraform_remote_state.vpc.aws_route_table.private.ids[count.index]}"
  destination_cidr_block    = "10.0.0.0/8"
  instance_id = "${aws_instance.meraki_vmx.id}"
}

resource "aws_route" "fort_knox_vmx" {
  route_table_id            = "${data.terraform_remote_state.vpc.aws_route_table.fortknox.id}"
  destination_cidr_block    = "10.0.0.0/8"
  instance_id = "${aws_instance.meraki_vmx.id}"
}
