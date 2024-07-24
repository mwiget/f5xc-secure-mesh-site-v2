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

variable "vsphere_server" {}
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_datacenter" {}
variable "vsphere_cluster" {}
variable "vsphere_datastore" {
  type = string
  default = "datastore1"
}
variable "vsphere_host" {
  type = string
  default = ""
}

variable "outside_network" {}
variable "slo_interface" {
  type = string
  default = "ens192"
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
variable "publicdefaultgateway" {
  type = string
  default = ""
}
variable "publicdefaultroute" {
  type = string
  default = ""
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
variable "f5xc_ova_image" {
  type = string
  default = ""
}
variable "f5xc_vm_template" {
  type = string
  default = ""
}

variable "guest_type" {
  type    = string
  default = "rhel8_64Guest"
}
variable "admin_password" {
  type = string
  default = "Volterra123"
  description = "admin shell password, needs at least one uppercase letter"
}
variable "f5xc_http_proxy" {
  type    = string
  default = ""
}
variable "dnsservers" {
  type = map(string)
  default = {}
}
