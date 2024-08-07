module "site-on-appstack" {
  count                   = var.site_on_appstack_count
  source                  = "./site"
  f5xc_cluster_name       = format("%s-site-on-appstack-%d", var.project_prefix, count.index)
  secure_mesh_site_provider = "kvm"
  kubeconfig              = var.kubeconfig
  f5xc_rhel9_container    = var.f5xc_rhel9_container


  master_node_count       = 1
  worker_node_count       = 0

  master_cpus             = 4
  master_memory           = 16384

  worker_cpus             = 4
  worker_memory           = 16384

  ssh_public_key          = var.ssh_public_key
  slo_interface           = "enp1s0"
  outside_network         = "ves-system/mw-milan1-enp193s0f1-0-vfio"
  #outside_network         = "ves-system/mw-milan1-enp193s0f1-0-vfio"  # temp used as SLI

  sli_interface             = "ens18"
  inside_network            = "vmbr0"
  inside_network_vlan       = "100"
  inside_vip                = "192.168.100.5"
  inside_ipv4_prefix        = "192.168.100.0/24"
  inside_dhcp_pool_start    = "192.168.100.10"
  inside_dhcp_pool_end      = "192.168.100.200"
  
  # set  to generate fixed  macaddr per node (last octet set to node index)
  # outside_macaddr       = "02:02:02:00:00:00"   

  f5xc_tenant             = var.f5xc_tenant
  f5xc_api_url            = var.f5xc_api_url
  f5xc_api_token          = var.f5xc_api_token
}
