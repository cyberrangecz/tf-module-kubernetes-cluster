output "cluster_ip" {
  value       = var.ha ? openstack_lb_loadbalancer_v2.lb[0].vip_address : openstack_networking_floatingip_v2.kubernetes_cluster_fip[0].address
  description = "Floating IP address of KYPO kubernetes cluster instance"
}

output "kubernetes_private_key" {
  value       = tls_private_key.terraform_user.private_key_pem
  description = "Private key of Kubernetes user"
}

output "kubernetes_certificate" {
  value       = tls_locally_signed_cert.terraform_user.cert_pem
  description = "Public key of Kubernetes user"
}

output "node_1_ip" {
  value       = var.ha ? openstack_compute_instance_v2.node_first[0].access_ip_v4 : null
  description = "Internal IP of the first node in HA setup"
}

output "node_2_ip" {
  value       = var.ha ? openstack_compute_instance_v2.node_add[0].access_ip_v4 : null
  description = "Internal IP of the second node in HA setup"
}

output "node_3_ip" {
  value       = var.ha ? openstack_compute_instance_v2.node_add[1].access_ip_v4 : null
  description = "Internal IP of the third node in HA setup"
}
