module "proxmox" {
  count                     = var.proxmox_site_count
  source                    = "./site"
  f5xc_cluster_name         = format("%s-proxmox-%d", var.project_prefix, count.index)
  secure_mesh_site_provider = "kvm"
  pm_clone                  = var.pm_clone
  pm_storage_pool           = var.pm_storage_pool
  iso_storage_pool          = var.iso_storage_pool

  master_node_count         = 1
  worker_node_count         = 0

  master_cpus               = 4
  master_memory             = 16384

  worker_cpus               = 4
  worker_memory             = 16384

  ssh_public_key            = var.ssh_public_key
  pm_target_nodes           = var.pm_target_nodes
  outside_network           = "vmbr0"

  inside_network            = "vmbr0"
  inside_network_vlan       = "100"

  #  inside_vip                = "192.168.100.5"
  #  inside_ipv4_prefix        = "192.168.100.0/24"
  #  inside_dhcp_pool_start    = "192.168.100.10"
  #  inside_dhcp_pool_end      = "192.168.100.200"
  
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token

}
