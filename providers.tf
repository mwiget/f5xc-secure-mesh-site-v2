provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
  timeout      = "30s"
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_user             = var.pm_user
  pm_password         = var.pm_password
  pm_tls_insecure     = true
}

provider "restapi" {
  uri = var.f5xc_api_url
  create_returns_object = true
  headers = {
    Authorization = format("APIToken %s", var.f5xc_api_token)
    Content-Type  = "application/json"
  }
}

provider "vsphere" {
  user                  = var.vsphere_user
  password              = var.vsphere_password
  vsphere_server        = var.vsphere_server
  allow_unverified_ssl  = true
}

provider "aws" {
  region      = "eu-north-1"
  alias       = "eu-north-1"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}

provider "aws" {
  region      = "us-east-1"
  alias       = "us-east-1"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}

provider "azurerm" {                                                                              
  subscription_id = var.azure_subscription_id != "" ? "" : var.azure_subscription_id
  client_id       = var.azure_client_id != "" ? "" : var.azure_client_id 
  client_secret   = var.azure_client_secret != "" ? "" : var.azure_client_secret
  tenant_id       = var.azure_tenant_id != "" ? "" : var.azure_tenant_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

provider "google" {
  alias       = "europe_west6"
  region      = "europe-west6"
  project     = var.gcp_project_id
  credentials = var.gcloud_credentials
}
