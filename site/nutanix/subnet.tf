data "nutanix_subnet" "slo" {
  subnet_name = var.outside_network
}

data "nutanix_subnet" "sli" {
  subnet_name = var.inside_network
}
