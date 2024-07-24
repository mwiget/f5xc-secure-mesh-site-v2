output "site" {
  value = {
    aws               = module.aws
    proxmox           = module.proxmox
    vmware            = module.vmware
    site-on-appstack  = module.site-on-appstack
  }
  sensitive = true
}
