module "node-on-appstack" {
  count                     = var.type == "appstack" ? 1 : 0
  source                  = "./appstack"
  f5xc_cluster_name       = var.f5xc_cluster_name
  kubeconfig              = var.kubeconfig
  f5xc_rhel9_container    = var.f5xc_rhel9_container

  master_node_count       = var.master_node_count
  worker_node_count       = var.worker_node_count

  master_cpus             = var.master_cpus
  master_memory           = var.master_memory

  worker_cpus             = var.worker_cpus
  worker_memory           = var.worker_memory

  ssh_public_key          = var.ssh_public_key
  outside_network         = var.outside_network
  slo_interface           = var.slo_interface
  outside_macaddr         = var.outside_macaddr

  f5xc_registration_token   = terraform_data.token.input
}
