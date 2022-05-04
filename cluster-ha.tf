resource "random_password" "token" {
  count   = var.ha ? 1 : 0
  length  = 32
  special = false
}

locals {
  user_data_first = templatefile("${path.module}/templates/cloud-config-first.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    secret               = var.ha ? random_password.token[0].result : ""
  })
  user_data_add = templatefile("${path.module}/templates/cloud-config-add.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    secret               = var.ha ? random_password.token[0].result : ""
    first_node           = var.ha ? openstack_compute_instance_v2.node_first[0].access_ip_v4 : ""
  })
}

data "template_file" "cloud_config_first" {
  count    = var.ha ? 1 : 0
  template = local.user_data_first
}

resource "openstack_compute_instance_v2" "node_first" {
  count           = var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-node-0"
  flavor_name     = var.flavor_name
  image_id        = var.image_id
  key_pair        = var.key_pair
  user_data       = data.template_file.cloud_config_first[0].rendered
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }
}

resource "null_resource" "provision_first" {
  count = var.ha ? 1 : 0
  connection {
    type         = "ssh"
    user         = "ubuntu"
    private_key  = var.private_key
    host         = openstack_compute_instance_v2.node_first[0].access_ip_v4
    bastion_host = var.proxy_host
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
}

data "template_file" "cloud_config_add" {
  count    = var.ha ? 1 : 0
  template = local.user_data_add
}

resource "openstack_compute_instance_v2" "node_add" {
  count           = var.ha ? 2 : 0
  name            = "${terraform.workspace}-kubernetes-node-${count.index + 1}"
  flavor_name     = var.flavor_name
  image_id        = var.image_id
  key_pair        = var.key_pair
  user_data       = data.template_file.cloud_config_add[0].rendered
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }

  depends_on = [
    null_resource.provision_first
  ]
}
