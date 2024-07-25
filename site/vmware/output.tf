output "nodes" {
  value = {
    master  = vsphere_virtual_machine.master-vm
    worker  = vsphere_virtual_machine.worker-vm
  }
}

output "ip_address" {
  value = {
    for node in concat(vsphere_virtual_machine.master-vm, vsphere_virtual_machine.worker-vm):
    node.name => node.default_ip_address
  }
}
