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

output "token" {
  value = { 
    content         = restapi_object.token.api_data
    #content2        = jsondecode(restapi_object.token.api_data["spec"])
    content         = regex("content:(\\S+)", restapi_object.token.api_data.spec)[0]
    site_name       = regex("site_name:(\\S+)", restapi_object.token.api_data.spec)[0]
    token_algorithm = jsondecode(base64decode(split(".", regex("content:(\\S+)", restapi_object.token.api_data.spec)[0])[0]))
    token_map       = jsondecode(base64decode(split(".", regex("content:(\\S+)", restapi_object.token.api_data.spec)[0])[1]))
  }
}
