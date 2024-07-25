output "site" {
  value = {
    aws               = module.aws
    proxmox           = module.proxmox
    vmware            = module.vmware
    site-on-appstack  = module.site-on-appstack
  }
  sensitive = true
}

#output "ip_address" {
#  value = {
#    proxmox           = module.proxmox[*].node.proxmox[*].ip_address
#    vmware            = module.vmware[*].node.vmware[*].ip_address
#  }
#}
output "ip_address" {
  value = concat(module.proxmox[*].node.proxmox[*].ip_address, module.vmware[*].node.vmware[*].ip_address)
}
