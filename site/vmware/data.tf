data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "outside" {
  name          = var.outside_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "inside" {
  name          = var.inside_network == "" ? var.outside_network : var.inside_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  count = var.f5xc_vm_template == "" ? 0 : 1
  name = var.f5xc_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}
