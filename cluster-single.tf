locals {
  user_data = templatefile("${path.module}/templates/cloud-config.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    k3s_version          = var.k3s_version
  })
}

data "template_file" "cloud_config" {
  count    = !var.ha ? 1 : 0
  template = local.user_data
}

resource "openstack_compute_instance_v2" "kubernetes_cluster" {
  count           = !var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-cluster"
  flavor_name     = var.flavor_name
  image_id        = var.os_volume ? null : var.image_id
  key_pair        = var.key_pair
  user_data       = data.template_file.cloud_config[0].rendered
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }

  dynamic "block_device" {
    for_each = var.os_volume ? [1] : []
    content {
      uuid                  = var.image_id
      source_type           = "image"
      volume_size           = var.os_volume_size
      boot_index            = 0
      destination_type      = "volume"
      delete_on_termination = true
    }
  }

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "null_resource" "provision_cluster" {
  count = !var.ha ? 1 : 0
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
    host        = openstack_networking_floatingip_v2.kubernetes_cluster_fip[0].address
    timeout     = "20m"
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
  count = !var.ha ? 1 : 0
  pool  = var.external_network_name
}

resource "openstack_compute_floatingip_associate_v2" "kubernetes_cluster_fip_association" {
  count       = !var.ha ? 1 : 0
  floating_ip = openstack_networking_floatingip_v2.kubernetes_cluster_fip[0].address
  instance_id = openstack_compute_instance_v2.kubernetes_cluster[0].id
}
