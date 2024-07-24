module "aws" {
  count                     = 0
  source                    = "./site"
  f5xc_cluster_name         = format("%s-aws-%d", var.project_prefix, count.index)
  secure_mesh_site_provider = "aws"
  aws_instance_type         = "t3.xlarge"
  aws_region                = "us-east-1"
  aws_availability_zones    = var.aws_availability_zones
  aws_ami_name              = var.aws_ami_name

  providers       = {
    aws           = aws.us-east-1
  }

  master_node_count         = 1
  worker_node_count         = 0

  ssh_public_key            = var.ssh_public_key
  #  slo_interface             = "ens18"
  #  outside_network           = "vmbr0"
  # outside_macaddr       = "02:02:02:00:00:00"   # last octet replaced with node index

  aws_owner_tag             = var.aws_owner_tag
  aws_vpc_cidr              = "10.0.0.0/16"
  aws_slo_subnets           = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  aws_sli_subnets           = [ "10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  #sli_interface             = "ens18"
  #inside_network            = "vmbr0"
  #inside_network_vlan       = "100"
  #inside_vip                = "192.168.100.5"
  #inside_ipv4_prefix        = "192.168.100.0/24"
  #inside_dhcp_pool_start    = "192.168.100.10"
  #inside_dhcp_pool_end      = "192.168.100.200"
 
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
  wait_for_online           = var.wait_for_online
}
