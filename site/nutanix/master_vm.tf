resource "nutanix_image" "master_image" {
  count       = var.master_node_count
  name        = format("%s-m%s", var.f5xc_cluster_name, count.index)
  description = "F5XC Securemesh V2 qcow2 image"
  source_uri  = var.nutanix_image_url
}

resource "nutanix_virtual_machine" "master-vm" {
  count             = var.master_node_count
  name              = format("%s-m%s", var.f5xc_cluster_name, count.index)
  cluster_uuid      = data.nutanix_clusters.clusters.entities.0.metadata.uuid

  num_vcpus_per_socket  = var.master_cpus
  num_sockets           = 1
  memory_size_mib       = var.master_memory
  guest_customization_cloud_init_user_data = length(var.outside_ip_address) == 0 ? base64encode(<<EOT
#cloud-config
users:
  - default
ssh_authorized_keys:
  - ${var.ssh_public_key}
write_files:
- path: /etc/vpm/user_data
  permissions: 0644
  owner: root
  content: |
    token: ${var.f5xc_registration_token}
EOT
  ) : base64encode(<<EOT
#cloud-config
users:
  - default
ssh_authorized_keys:
  - ${var.ssh_public_key}
write_files:
- path: /etc/vpm/user_data
  permissions: 0644
  owner: root
  content: |
    token: ${var.f5xc_registration_token}
    slo_ip: ${var.outside_ip_address[count.index]}
    slo_gateway: ${var.outside_ip_gateway}
    slo_dns: ${var.outside_ip_dns}
EOT
  )

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = nutanix_image.master_image[count.index].id
    }
  }

  nic_list {
    subnet_uuid = data.nutanix_subnet.slo.id
  }

  dynamic "nic_list" {
    for_each =  var.inside_network == "" ? [] : [ var.inside_network ]
    content {
      subnet_uuid = data.nutanix_subnet.sli.id
    }
  }

  lifecycle {
    ignore_changes = all
  }
}
