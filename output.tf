output "site" {
  value = {
    aws               = module.aws
    proxmox           = module.proxmox
    vmware            = module.vmware
    site-on-appstack  = module.site-on-appstack
  }
  sensitive = true
}

output "ip_address" {
  value = concat(
    module.aws[*].node.aws[*].ip_address, 
    module.proxmox[*].node.proxmox[*].ip_address, 
    module.vmware[*].node.vmware[*].ip_address,
    module.nutanix[*].node.nutanix[*].ip_address
  )
}
