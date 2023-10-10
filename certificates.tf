resource "tls_private_key" "kubernetes_ca" {
  count       = 3
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "kubernetes_ca_certs" {
  count = 3

  validity_period_hours = 87660
  allowed_uses          = ["digital_signature", "key_encipherment", "cert_signing"]
  private_key_pem       = tls_private_key.kubernetes_ca[count.index].private_key_pem
  is_ca_certificate     = true

  subject {
    common_name = "kubernetes-ca"
  }
}

resource "tls_private_key" "terraform_user" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_cert_request" "terraform_user" {
  private_key_pem = tls_private_key.terraform_user.private_key_pem

  subject {
    common_name  = "terraform-user"
    organization = "system:masters"
  }
}

resource "tls_locally_signed_cert" "terraform_user" {
  cert_request_pem      = tls_cert_request.terraform_user.cert_request_pem
  ca_private_key_pem    = tls_private_key.kubernetes_ca[0].private_key_pem
  ca_cert_pem           = tls_self_signed_cert.kubernetes_ca_certs[0].cert_pem
  validity_period_hours = 87660
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth"
  ]
}
