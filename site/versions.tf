terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.34"
    }
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
    restapi = {
      source = "Mastercard/restapi"
      version = "1.19.1"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.8.2"
    }    
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.56.1"
    }    
  }
}
