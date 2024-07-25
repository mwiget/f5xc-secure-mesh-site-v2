output "nodes" {
  value = {
    master  = proxmox_vm_qemu.master-vm
    worker  = proxmox_vm_qemu.worker-vm
  }
}

output "ip_address" {
  value = {
    for node in concat(proxmox_vm_qemu.master-vm, proxmox_vm_qemu.worker-vm):
    node.name => node.default_ipv4_address
  }
}
