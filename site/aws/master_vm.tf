resource "aws_instance" "master_vm" {
  count         = var.master_node_count
  ami           = data.aws_ami_ids.smsv2.ids[0]
  instance_type = var.aws_instance_type

  root_block_device {
    volume_size = var.ec2_disk_size
  }

  network_interface {
    network_interface_id = element(aws_network_interface.sm_slo_eni[*].id, count.index)
    device_index         = 0
  }
  network_interface {
    network_interface_id = element(aws_network_interface.sm_sli_eni[*].id, count.index)
    device_index         = 1
  }

  user_data = templatefile("${path.module}/templates/cloud-config-base.tmpl", {
      ssh_public_key = var.ssh_public_key,
      node_registration_token = var.f5xc_registration_token
  })

  tags = {
    Name = format("%s-m%d", var.f5xc_cluster_name, count.index)
    ves-io-site-name = var.f5xc_cluster_name
    "kubernetes.io/cluster/${var.f5xc_cluster_name}" = "owned"
    Creator = var.aws_owner_tag
  }
}

resource "aws_network_interface" "sm_slo_eni" {
  depends_on      = [ aws_subnet.slo ]
  count           = var.master_node_count
  subnet_id       = element(aws_subnet.slo[*].id, count.index)
  security_groups = [ resource.aws_security_group.allow_slo_traffic.id ]
  tags = {
    Name = format("%s-pub-eni-%d", var.f5xc_cluster_name, count.index)
    Creator = var.aws_owner_tag
  }
}

resource "aws_network_interface" "sm_sli_eni" {
  depends_on      = [ aws_subnet.sli ]
  count           = var.master_node_count
  subnet_id       = element(aws_subnet.sli[*].id, count.index)
  security_groups = [ resource.aws_security_group.allow_sli_traffic.id ]
  source_dest_check = false

  tags = {
    Name = format("%s-priv-eni-%d", var.f5xc_cluster_name, count.index)
    Creator = var.aws_owner_tag
  }
}

resource "aws_eip" "sm_pub_ips" {
  count             = var.master_node_count
}

resource "aws_eip_association" "master_vm" {
  count                = var.master_node_count
  network_interface_id = aws_network_interface.sm_slo_eni[count.index].id
  allocation_id        = aws_eip.sm_pub_ips[count.index].id

  depends_on = [aws_instance.master_vm]
}
