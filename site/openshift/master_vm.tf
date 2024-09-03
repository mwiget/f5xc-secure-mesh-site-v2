resource "terraform_data" "master-mv" {
  count      = var.master_node_count
  depends_on = [ local_file.kubectl_manifest_master ]
  input      = {
    manifest   = "manifest/${var.f5xc_cluster_name}_m${count.index}.yaml"
    kubeconfig = var.kubeconfig
    name       = "${var.f5xc_cluster_name}-m${count.index}"
  }

  provisioner "local-exec" {
    command    = "kubectl apply -f ${self.input.manifest} --kubeconfig ${self.input.kubeconfig} && sleep 5 && kubectl wait --for=condition=ready pod -l vm.kubevirt.io/name=${self.input.name} --kubeconfig ${self.input.kubeconfig}"
  }
  provisioner "local-exec" {
    when       = destroy
    on_failure = continue
    command    = "kubectl delete -f ${self.input.manifest} --kubeconfig ${self.input.kubeconfig}"
  }
}

resource "local_file" "kubectl_manifest_master" {
    count                    = var.master_node_count
    content                  = templatefile("${path.module}/templates/rhel9-node-template.yaml", {
    cluster-name             = var.f5xc_cluster_name
    host-name                = format("m%d", count.index)
    site-registration-token  = var.f5xc_registration_token
    f5xc_rhel9_container     = var.f5xc_rhel9_container
    ssh_public_key           = var.ssh_public_key
    cpus                     = var.master_cpus
    memory                   = var.master_memory
  })
  filename = "manifest/${var.f5xc_cluster_name}_m${count.index}.yaml"
}
