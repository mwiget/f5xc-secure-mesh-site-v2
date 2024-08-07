module "vmware-node" {
  count                     = var.f5xc_vm_template == "" ? 0 : 1
  source                    = "./vmware"
  f5xc_cluster_name         = var.f5xc_cluster_name

  f5xc_vm_template          = var.f5xc_vm_template
  vsphere_user              = var.vsphere_user
  vsphere_password          = var.vsphere_password
  vsphere_server            = var.vsphere_server
  vsphere_datacenter        = var.vsphere_datacenter
  vsphere_cluster           = var.vsphere_cluster
  vsphere_datastore         = var.vsphere_datastore

  master_node_count         = var.master_node_count
  worker_node_count         = var.worker_node_count

  master_cpus               = var.master_cpus
  master_memory             = var.master_memory

  worker_cpus               = var.worker_cpus
  worker_memory             = var.worker_memory

  ssh_public_key            = var.ssh_public_key
  slo_interface             = var.slo_interface
  outside_network           = var.outside_network
  outside_macaddr           = var.outside_macaddr

  dnsservers                = var.dnsservers

  inside_network            = var.inside_network
  inside_network_vlan       = var.inside_network_vlan
  inside_vip                = var.inside_vip
  inside_ipv4_prefix        = var.inside_ipv4_prefix
  inside_dhcp_pool_start    = var.inside_dhcp_pool_start
  inside_dhcp_pool_end      = var.inside_dhcp_pool_end
  
  f5xc_registration_token   = terraform_data.token.input
}
