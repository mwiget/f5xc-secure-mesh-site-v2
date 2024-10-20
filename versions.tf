terraform {
  required_providers {
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
      version = ">= 5.68.0"
    }    
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.110.0"
    }
    google = {
      source = "hashicorp/google"
      version = ">=5.36.0"
    }
    nutanix = {
      source = "nutanix/nutanix"
      version = ">= 1.9.5"
    }
  }
}
