module "vmware" {
  count                     = var.vmware_site_count
  source                    = "./site"
  f5xc_cluster_name         = format("%s-vmware-%d", var.project_prefix, count.index)
  secure_mesh_site_provider = "vmware"

  f5xc_vm_template          = var.f5xc_vm_template
  vsphere_user              = var.vsphere_user
  vsphere_password          = var.vsphere_password
  vsphere_server            = var.vsphere_server
  vsphere_datacenter        = var.vsphere_datacenter
  vsphere_cluster           = var.vsphere_cluster
  vsphere_datastore         = var.vsphere_datastore

  master_node_count         = 3
  worker_node_count         = 0

  master_cpus               = 4
  master_memory             = 16384

  worker_cpus               = 4
  worker_memory             = 16384

  ssh_public_key            = var.ssh_public_key
  slo_interface             = "ens192"
  outside_network           = "VM Network"
  # outside_macaddr       = "02:02:02:00:00:00"   # last octet replaced with node index
  inside_network            = "VM Network 100"

  dnsservers             = {
    primary = "1.1.1.1"
    secondary = "8.8.8.8"
  }

  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
}
