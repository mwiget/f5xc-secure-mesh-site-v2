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
  default = "vmbr0"
}
variable "slo_interface" {
  type = string
  default = "eth0"
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
  default = "80G"
}
variable "worker_vm_size" {
  type = string
  default = "80G"
}
variable "slo_global_vn" {
  type = string
  default = ""
}

# Proxmox

variable "pm_target_nodes" {
  type = list(string)
  default = []
}
variable "iso_storage_pool" {
  type = string
  default = "local"
}
variable "pm_storage_pool" {
  type = string
  default = "local-lvm"
}
variable "pm_clone" {}
variable "pm_pool" {
  type = string
  default = ""
}
variable "master_hostpci" {
  type = list(string)
  default = []
}
variable "worker_hostpci" {
  type = list(string)
  default = []
}
