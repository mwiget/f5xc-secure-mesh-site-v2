variable "f5xc_cluster_name" {}
variable "f5xc_registration_token" {}

variable "ssh_public_key" {}
variable "master_node_count" {
  type = number
  default = 0
}
variable "worker_node_count" {
  type = number
  default = 0
}
variable "http_proxy" {
  type = string
  default = ""
}
variable "master_cpus" {
  type = number
  default = 4
}
variable "master_memory" {
  type = number
  default = 16384
}
variable "worker_cpus" {
  type = number
  default = 4
}
variable "worker_memory" {
  type = number
  default = 16384
}
variable "outside_network" {
  type = string
  default = ""
}
variable "outside_ip_address" {
  type = list(string)
  default = []
}
variable "outside_ip_gateway" {
  type = string
  default = ""
}
variable "outside_ip_dns" {
  type = string
  default = ""
}
variable "slo_interface" {
  type = string
}
variable "outside_network_vlan" {
  type = number
  default = -1
}
variable "inside_network" {
  type = string
  default = ""
}
variable "inside_network_vlan" {
  type = number
  default = -1
}
variable "inside_ipv4_prefix" {
  type = string
  default = "192.168.100.0/24"
}
variable "inside_dhcp_pool_start" {
  type = string
  default = "192.168.100.10"
}
variable "inside_dhcp_pool_end" {
  type = string
  default = "192.168.100.200"
}
variable "outside_macaddr" {
  type    = string
  default = ""
}
variable "inside_vip" {
  type  = string
  default = ""
}
variable "master_vm_size" {
  type = string
  default = "50G"
}
variable "worker_vm_size" {
  type = string
  default = "50G"
}
variable "slo_global_vn" {
  type = string
  default = ""
}

# nutanix

variable "nutanix_image_url" {
  type = string
}
