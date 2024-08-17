resource "vsphere_virtual_machine" "master-vm" {
  count            = var.master_node_count
  name             = format("%s-m%s", var.f5xc_cluster_name, count.index)
  datacenter_id    = var.f5xc_ova_image == "" ? "" : data.vsphere_datacenter.dc.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.master_cpus
  memory   = var.master_memory
  guest_id = var.guest_type

  network_interface {
    network_id   = data.vsphere_network.outside.id
    adapter_type = "vmxnet3"
  }
  dynamic "network_interface" {
    for_each = var.inside_network == "" ? [] : [0]
    content {
      network_id   = data.vsphere_network.inside.id
      adapter_type = "vmxnet3"
    }
  }

  disk {
    label            = "disk0"
    size             = 80
    eagerly_scrub    = false
    thin_provisioned = false
  }

  dynamic "ovf_deploy" {
    for_each = var.f5xc_ova_image == "" ? [] : [0]
    content {
      allow_unverified_ssl_cert = true
      local_ovf_path            = var.f5xc_ova_image
      enable_hidden_properties  = true
      disk_provisioning         = "thin"

      ovf_network_map = var.inside_network == "" ? { 
        "OUTSIDE" = data.vsphere_network.outside.id 
      } : {
        "OUTSIDE" = data.vsphere_network.outside.id
        "REGULAR" = data.vsphere_network.inside.id
      }
    }
  }

  dynamic "clone" {
   for_each = var.f5xc_vm_template == "" ? [] : [0]
   content {
    template_uuid = data.vsphere_virtual_machine.template[0].id
   }
  }

  vapp {
    properties = {
      "guestinfo.hostname"                        = format("%s-m%s", var.f5xc_cluster_name, count.index)
      "guestinfo.ves.token"                       = var.f5xc_registration_token,
      "guestinfo.ves.adminpassword"               = var.admin_password,
      "guestinfo.interface.0.dhcp"                = "yes",
      #      "guestinfo.interface.0.ip.0.address"        = "",
      "guestinfo.interface.0.route.0.gateway"     = var.publicdefaultgateway,
      "guestinfo.interface.0.route.0.destination" = var.publicdefaultroute,
      "guestinfo.dns.server.0"                    = var.dnsservers["primary"],
      "guestinfo.dns.server.1"                    = var.dnsservers["secondary"],
    }
  }

  lifecycle {
    ignore_changes = [
      annotation,
      disk[0].io_share_count,
      disk[1].io_share_count,
      disk[2].io_share_count,
      vapp[0].properties,
      ept_rvi_mode,
      hv_mode
    ]
  }
}
