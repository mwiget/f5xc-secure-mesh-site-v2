output "nodes" {
  value = {
    master  = nutanix_virtual_machine.master-vm
    #    worker  = nutanix_virtual_machine.worker-vm
  }
}

output "ip_address" {
  value = {
    for node in concat(nutanix_virtual_machine.master-vm):
   node.name => node.nic_list_status[0].ip_endpoint_list[0].ip
  }
}
