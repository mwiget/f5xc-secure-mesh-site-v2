module "site_wait_for_online" {
  count           = var.wait_for_online == true ? 1: 0
  depends_on      = [ restapi_object.site ]
  source          = "./status"
  f5xc_api_token  = var.f5xc_api_token
  f5xc_api_url    = var.f5xc_api_url
  f5xc_namespace  = "system"
  f5xc_site_name  = var.f5xc_cluster_name
  f5xc_tenant     = var.f5xc_tenant
}
