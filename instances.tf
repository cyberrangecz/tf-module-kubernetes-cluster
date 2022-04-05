locals {
  user_data = templatefile("${path.module}/config/cloud-config.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
  })
}

data "template_file" "cloud_config" {
  template = local.user_data
}

resource "openstack_compute_instance_v2" "kubernetes_cluster" {
  name            = "kypo-kubernetes-cluster"
  flavor_name     = var.flavor_name
  image_id        = var.image_id
  key_pair        = var.key_pair
  user_data       = data.template_file.cloud_config.rendered
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }
}

resource "null_resource" "provision" {
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
    host        = openstack_networking_floatingip_v2.kubernetes_cluster_fip.address
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }

  depends_on = [
    openstack_compute_floatingip_associate_v2.kubernetes_cluster_fip_association
  ]
}

resource "openstack_networking_floatingip_v2" "kubernetes_cluster_fip" {
  pool = var.external_network_name
}

resource "openstack_compute_floatingip_associate_v2" "kubernetes_cluster_fip_association" {
  floating_ip = openstack_networking_floatingip_v2.kubernetes_cluster_fip.address
  instance_id = openstack_compute_instance_v2.kubernetes_cluster.id
}
