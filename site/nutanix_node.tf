module "nutanix-node" {
  count                     = var.nutanix_image_url == "" ? 0 : 1
  source                    = "./nutanix"
  f5xc_cluster_name         = var.f5xc_cluster_name

  master_node_count         = var.master_node_count
  worker_node_count         = var.worker_node_count

  nutanix_image_url         = var.nutanix_image_url
  master_cpus               = var.master_cpus
  master_memory             = var.master_memory

  worker_cpus               = var.worker_cpus
  worker_memory             = var.worker_memory

  ssh_public_key            = var.ssh_public_key
  slo_interface             = var.slo_interface
  outside_network           = var.outside_network
  outside_macaddr           = var.outside_macaddr
  outside_ip_address        = var.outside_ip_address
  outside_ip_gateway        = var.outside_ip_gateway
  outside_ip_dns            = var.outside_ip_dns

  inside_network            = var.inside_network
  inside_network_vlan       = var.inside_network_vlan
  inside_vip                = var.inside_vip
  inside_ipv4_prefix        = var.inside_ipv4_prefix
  inside_dhcp_pool_start    = var.inside_dhcp_pool_start
  inside_dhcp_pool_end      = var.inside_dhcp_pool_end
  
  f5xc_registration_token   = terraform_data.token.input
}
