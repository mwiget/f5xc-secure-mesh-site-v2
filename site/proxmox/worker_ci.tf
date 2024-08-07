resource "proxmox_cloud_init_disk" "worker-ci" {
  count     = var.worker_node_count
  name      = format("%s-w%s", var.f5xc_cluster_name, count.index)
  pve_node  = var.pm_target_nodes[count.index % length(var.pm_target_nodes)]
  storage   = var.iso_storage_pool

  meta_data = yamlencode({
    instance_id    = sha1(format("%s-w%s", var.f5xc_cluster_name, count.index))
    local-hostname = format("%s-w%s", var.f5xc_cluster_name, count.index)
  })

  user_data = <<EOT
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
}
