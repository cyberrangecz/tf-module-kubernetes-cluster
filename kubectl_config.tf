resource "local_file" "kubectl_config" {
  content = templatefile("${path.module}/templates/kubectl-config.tpl", {
    server                  = var.ha ? openstack_lb_loadbalancer_v2.lb[0].vip_address : openstack_networking_floatingip_v2.kubernetes_cluster_fip[0].address
    client_certificate_data = base64encode(tls_locally_signed_cert.terraform_user.cert_pem)
    client_key_data         = base64encode(tls_private_key.terraform_user.private_key_pem)
    workspace               = terraform.workspace
  })
  filename        = "config"
  file_permission = "0600"
}
