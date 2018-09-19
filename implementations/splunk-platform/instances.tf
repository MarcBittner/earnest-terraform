/* This instance describes a splunk search head instance. */

resource "aws_instance" "rs-sh" {
  ami           = "${var.sh_ami}"
  instance_type = "${var.rs-sh_instance[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "rs-splunk-search"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_ui.id}"]
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh splunk-search-rs.${var.local_domain} 1 /tmp/splunk_ring search ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

resource "aws_instance" "sh" {
  ami           = "${var.sh_ami}"
  instance_type = "${var.sh_instance[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "splunk-search"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_ui.id}"]
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh splunk-search-ah.${var.local_domain} 1 /tmp/splunk_ring search ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

/* This describes a splunk enterprise security search head instance. */
resource "aws_instance" "sh-es" {
  ami                    = "${var.es_ami}"
  instance_type          = "${var.es_instance[terraform.workspace]}"
  tags                   = "${merge(local.common_tags, map("Name", "splunk-search-es"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_ui.id}"]
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh splunk-search-es.${var.local_domain} 1 /tmp/splunk_ring search ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

/* This is the splunk deployment server instance. */
resource "aws_instance" "ds" {
  ami           = "${var.ds_ami}"
  instance_type = "${var.ds_instance[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "splunk-deployment-server"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_ui.id}"]
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh deployment_server 0 /tmp/splunk_ring deployment_server ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

/* This Describes the splunk cluster master instance. */
resource "aws_instance" "master" {
  ami                    = "${var.cm_ami}"
  instance_type          = "${var.cm_instance[terraform.workspace]}"
  tags                   = "${merge(local.common_tags, map("Name", "splunk-cluster-master"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_ui.id}"]
  subnet_id              = "${aws_subnet.public_subnet_a.id}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh splunk-master.${var.local_domain} 1 /tmp/splunk_ring splunk-master.${var.local_domain}  ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

/* This describes the splunk indexer instances. */
resource "aws_instance" "idx" {
  ami           = "${var.idx_ami}"
  instance_type = "${var.idx_instance[terraform.workspace]}"
  count         = "${var.num_idx_instances[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "splunk-indexer-${count.index}"))}"

  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.splunk_indexer_sec_group.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.az_subnets.ids, count.index)}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  ebs_block_device {
    device_name           = "/dev/xvdh"
    volume_size           = "${var.idx_hot_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  ebs_block_device {
    device_name           = "/dev/xvdc"
    volume_size           = "${var.idx_cold_storage}"
    volume_type           = "st1"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "file" {
    source      = "configure-hot-volume.sh"
    destination = "/tmp/configure-hot-volume.sh"
  }

  provisioner "file" {
    source      = "configure-cold-volume.sh"
    destination = "/tmp/configure-cold-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-*-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-hot-volume.sh",
      "sudo /tmp/configure-cold-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh indexer_peer 0 /tmp/splunk_ring indexer_peer ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }

  depends_on = ["aws_route53_record.master-ns"]
}

/* This describes the splunk heavy forwarder instances. */
resource "aws_instance" "hfwd" {
  ami           = "${var.hfwd_ami}"
  instance_type = "${var.hfwd_instance[terraform.workspace]}"
  count         = "${var.num_hf_instances[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "splunk-hforwarder-${count.index}"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.meraki_ingress_group.id}", "${aws_security_group.splunk_ui.id}", "${aws_security_group.cylance_ingress.id}", "${aws_security_group.http_forwarder.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.az_subnets.ids, count.index)}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh splunk-hforwarder-${count.index}.${var.local_domain} 1 /tmp/splunk_ring heavyforwarder ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}

resource "aws_instance" "power_hfwd" {
  ami           = "${var.hfwd_ami}"
  instance_type = "${var.p_hfwd_instance[terraform.workspace]}"
  count         = "${var.num_p_hf_instances[terraform.workspace]}"
  tags          = "${merge(local.common_tags, map("Name", "power-splunk-hforwarder-${count.index}"))}"
  key_name               = "${var.key_name[terraform.workspace]}"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.splunk_default_sec_group.id}", "${aws_security_group.meraki_ingress_group.id}", "${aws_security_group.splunk_ui.id}", "${aws_security_group.cylance_ingress.id}", "${aws_security_group.http_forwarder.id}"]
  subnet_id              = "${element(data.aws_subnet_ids.az_subnets.ids, count.index)}"

  ebs_block_device {
    device_name           = "/dev/xvds"
    volume_size           = "${var.root_storage}"
    volume_type           = "gp2"
    delete_on_termination = "${var.idx_storage_delete[terraform.workspace]}"
  }

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/${var.key_name[terraform.workspace]}.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/splunk_ring/bash_scripts",
    ]
  }

  provisioner "file" {
    source      = "bash_scripts"
    destination = "/tmp/splunk_ring/"
  }

  provisioner "file" {
    source      = "configure-base-volume.sh"
    destination = "/tmp/configure-base-volume.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo chmod 755 /tmp/configure-base-volume.sh",
      "sudo /tmp/configure-base-volume.sh",
      "sudo chmod 755 /tmp/splunk_ring/bash_scripts/*.sh",
      "sudo /tmp/splunk_ring/bash_scripts/install.sh power-splunk-hforwarder-${count.index}.${var.local_domain} 1 /tmp/splunk_ring heavyforwarder ${var.splunk_admin_password} ${var.splunk_secret} ${var.splunk_download_url}",
    ]
  }
}
