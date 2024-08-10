module "nutanix" {
  count                     = var.nutanix_site_count
  source                    = "./site"
  f5xc_cluster_name         = format("%s-nutanix-%d", var.project_prefix, count.index)
  secure_mesh_site_provider = "kvm"
  nutanix_image_url         = var.nutanix_image_url

  master_node_count         = 3
  worker_node_count         = 0

  master_cpus               = 4
  master_memory             = 16384

  worker_cpus               = 4
  worker_memory             = 16384

  ssh_public_key            = var.ssh_public_key
  outside_network           = "lab"
  #  outside_ip_address        = ["192.168.42.70/24", "192.168.42.71/24", "192.168.42.72/24"]
  #  outside_ip_gateway        = "192.168.42.1"
  #  outside_ip_dns            = "1.1.1.1"

  inside_network            = "inside"

  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
}
