module "aws-node" {
  count                     = var.aws_vpc_cidr == "" ? 0 : 1
  source                    = "./aws"
  f5xc_cluster_name         = var.f5xc_cluster_name

  master_node_count         = var.master_node_count
  worker_node_count         = var.worker_node_count

  ssh_public_key            = var.ssh_public_key

  aws_region                = var.aws_region
  aws_availability_zones    = var.aws_availability_zones
  aws_instance_type         = var.aws_instance_type
  aws_ami_name              = var.aws_ami_name

  aws_vpc_name              = format("%s-vpc", var.f5xc_cluster_name)
  aws_vpc_cidr              = var.aws_vpc_cidr
  aws_owner_tag             = var.aws_owner_tag

  aws_slo_subnets           = var.aws_slo_subnets
  aws_sli_subnets           = var.aws_sli_subnets

  #  slo_interface             = var.slo_interface
  #  outside_network           = var.outside_network
  #  outside_macaddr           = var.outside_macaddr
  #
  #  inside_network            = var.inside_networklllil
  #  inside_network_vlan       = var.inside_network_vlan
  #  inside_vip                = var.inside_vip
  #  inside_ipv4_prefix        = var.inside_ipv4_prefix
  #  inside_dhcp_pool_start    = var.inside_dhcp_pool_start
  #  inside_dhcp_pool_end      = var.inside_dhcp_pool_end
  
  f5xc_registration_token   = regex("content:(\\S+)", restapi_object.token.api_data.spec)[0]
}
