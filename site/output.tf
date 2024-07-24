output "node" {
  value = {
    aws               = module.aws-node
    proxmox           = module.proxmox-node
    vmware            = module.vmware-node
    node-on-appstack  = module.node-on-appstack
  }
}
