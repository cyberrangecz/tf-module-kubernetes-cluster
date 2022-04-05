output "cluster_ip" {
  value       = openstack_networking_floatingip_v2.kubernetes_cluster_fip.address
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
