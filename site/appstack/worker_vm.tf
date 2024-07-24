resource "terraform_data" "worker-vm" {
  count      = var.worker_node_count
  depends_on = [ local_file.kubectl_manifest_worker ]
  input      = {
    manifest   = "manifest/${var.f5xc_cluster_name}_m${count.index}.yaml"
    kubeconfig = var.kubeconfig
    name       = "${var.f5xc_cluster_name}-m${count.index}"
  }

  provisioner "local-exec" {
    command    = "kubectl apply -f ${self.input.manifest} --kubeconfig ${self.input.kubeconfig} && kubectl wait --for=condition=ready pod -l vm.kubevirt.io/name=${self.input.name} --kubeconfig ${self.input.kubeconfig}"
  }
  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "kubectl delete -f ${self.input.manifest} --kubeconfig ${self.input.kubeconfig}"
  }
}

resource "local_file" "kubectl_manifest_worker" {
    count                    = var.worker_node_count
    content                  = templatefile("${path.module}/templates/rhel9-node-template.yaml", {
    cluster-name             = var.f5xc_cluster_name
    host-name                = format("m%d", count.index)
    network                  = var.outside_network
    slo-nic                  = var.slo_interface
    site-registration-token  = var.f5xc_registration_token
    f5xc_rhel9_container     = var.f5xc_rhel9_container
  })
  filename = "manifest/${var.f5xc_cluster_name}_m${count.index}.yaml"
}
