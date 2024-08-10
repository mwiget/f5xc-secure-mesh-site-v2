variable "project_prefix" {
  type        = string
  default     = "f5xc"
}

# F5XC 

variable "f5xc_api_p12_file"   {}
variable "f5xc_api_url"        {}
variable "f5xc_api_token"      {}
variable "f5xc_tenant"         {}

# appstack cluster

variable "kubeconfig" {
  type = string
  default = ""
}
variable "f5xc_rhel9_container" {
  type = string
  default = ""
}

# vsphere/vwmware

variable "f5xc_vm_template" {
  type = string
  default = ""
}
variable "vsphere_server" {
  type = string
  default = ""
}
variable "vsphere_user" {
  type = string
  default = "administrator@vsphere.local"
}
variable "vsphere_password" {
  type = string
  default = ""
}
variable "vsphere_datacenter" {
  type = string
  default = ""
}
variable "vsphere_cluster" {
  type = string
  default = ""
}
variable "vsphere_datastore" {
  type = string
  default = "datastore1"
}
variable "vsphere_host" {
  type = string
  default = ""
}

# Proxmox

variable "pm_api_url"          {}
variable "pm_api_token_id"     {
  type    = string
  default = ""
}
variable "pm_api_token_secret" {
  type    = string
  default = ""
}
variable "pm_user"             {
  type    = string
  default = ""
}
variable "pm_password"         {
  type    = string
  default = ""
}
variable "pm_target_nodes"     {}
variable "pm_clone"            {}
variable "pm_pool" {
  type = string
  default = ""
}
variable "iso_storage_pool" {
  type = string
  default = "local"
}
variable "pm_storage_pool" {
  type = string
  default = "local-lvm"
}
variable "ssh_public_key"      {}

# AWS

variable "aws_access_key" {
  type = string
  default = ""
}
variable "aws_secret_key" {
  type = string
  default = ""
}
variable "aws_owner_tag" {
  type = string
  default = ""
}
variable "aws_region" {
  type = string
  default = ""
}
variable "aws_availability_zones" {
  type = list(string)
  default = []
}
variable "aws_ami_name" {
  type = string
}
variable "nutanix_username" {
  type = string
  default = "admin"
}
variable "nutanix_password" {
  type = string
  default = ""
}
variable "nutanix_endpoint" {
  type = string
  default = ""
}
variable "nutanix_port" {
  type = string
  default = "9440"
}
variable "nutanix_image_url" {
  type = string
  default = ""
}
variable "nutanix_site_count" {
  type = number
  default = 0
}
variable "vmware_site_count" {
  type = number
  default = 0
}
variable "proxmox_site_count" {
  type = number
  default = 0
}
variable "aws_site_count" {
  type = number
  default = 0
}
variable "site_on_appstack_count" {
  type = number
  default = 0
}
