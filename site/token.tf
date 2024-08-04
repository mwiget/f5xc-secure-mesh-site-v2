resource "restapi_object" "token" {
  id_attribute = "metadata/name"
  path         = "/register/namespaces/system/tokens"
  data         = jsonencode({
    "metadata": {
      "name": var.f5xc_cluster_name,
      "namespace": "system"
    }
    "spec": {
      "type": "JWT",
      "site_name": var.f5xc_cluster_name
    }
  })
}

resource "terraform_data" "token" {
  input      = regex("content:(\\S+)", restapi_object.token.api_data.spec)[0]
}

output "token" {
  value = terraform_data.token.input
}
