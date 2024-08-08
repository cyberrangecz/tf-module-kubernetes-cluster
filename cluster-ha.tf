resource "random_password" "token" {
  count   = var.ha ? 1 : 0
  length  = 32
  special = false
}

resource "openstack_compute_servergroup_v2" "server_group" {
  count    = var.ha ? 1 : 0
  name     = "${terraform.workspace}-server-group"
  policies = ["soft-anti-affinity"]
}

resource "openstack_compute_instance_v2" "node_initial_server" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-server-0"
  flavor_name = var.server_flavor_name
  image_id    = var.image_id
  key_pair    = var.key_pair
  user_data = templatefile("${path.module}/templates/cloud-config-initial-server.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    secret               = var.ha ? random_password.token[0].result : ""
    k3s_version          = var.k3s_version
  })
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.server_group[0].id
  }
}

resource "null_resource" "provision_initial_server" {
  count = var.ha ? 1 : 0
  connection {
    type         = "ssh"
    user         = "ubuntu"
    private_key  = var.private_key
    host         = openstack_compute_instance_v2.node_initial_server[0].access_ip_v4
    bastion_host = var.proxy_host
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
}

resource "openstack_compute_instance_v2" "node_server" {
  count       = var.ha ? var.server_count - 1 : 0
  name        = "${terraform.workspace}-kubernetes-server-${count.index + 1}"
  flavor_name = var.server_flavor_name
  image_id    = var.image_id
  key_pair    = var.key_pair
  user_data = templatefile("${path.module}/templates/cloud-config-node.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    secret               = var.ha ? random_password.token[0].result : ""
    first_node           = var.ha ? openstack_compute_instance_v2.node_initial_server[0].access_ip_v4 : ""
    k3s_version          = var.k3s_version
    k3s_exec_options     = "server --disable-apiserver --disable-controller-manager --disable-scheduler --disable-agent"
  })
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.server_group[0].id
  }

  depends_on = [
    null_resource.provision_initial_server
  ]

  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "openstack_compute_instance_v2" "node_agent" {
  count       = var.ha ? var.agent_count : 0
  name        = "${terraform.workspace}-kubernetes-agent-${count.index}"
  flavor_name = var.agent_flavor_name
  image_id    = var.image_id
  key_pair    = var.key_pair
  user_data = templatefile("${path.module}/templates/cloud-config-node.yml.tpl", {
    kubernetes_ca        = tls_private_key.kubernetes_ca
    kubernetes_ca_certs  = tls_self_signed_cert.kubernetes_ca_certs
    terraform_user       = tls_private_key.terraform_user
    terraform_user_certs = tls_locally_signed_cert.terraform_user
    secret               = var.ha ? random_password.token[0].result : ""
    first_node           = var.ha ? openstack_compute_instance_v2.node_initial_server[0].access_ip_v4 : ""
    k3s_version          = var.k3s_version
    k3s_exec_options     = "server --disable-etcd"
  })
  security_groups = [var.security_group]

  network {
    uuid = var.network_id
  }

  scheduler_hints {
    group = openstack_compute_servergroup_v2.server_group[0].id
  }

  depends_on = [
    null_resource.provision_initial_server
  ]

  lifecycle {
    ignore_changes = [user_data]
  }
}
