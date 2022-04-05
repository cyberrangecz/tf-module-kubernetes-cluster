<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.provision](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [openstack_compute_floatingip_associate_v2.kubernetes_cluster_fip_association](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_floatingip_associate_v2) | resource |
| [openstack_compute_instance_v2.kubernetes_cluster](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_networking_floatingip_v2.kubernetes_cluster_fip](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_v2) | resource |
| [tls_cert_request.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.kubernetes_ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.kubernetes_ca_certs](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [template_file.cloud_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_network_name"></a> [external\_network\_name](#input\_external\_network\_name) | External network name used for floating IP allocation | `string` | n/a | yes |
| <a name="input_flavor_name"></a> [flavor\_name](#input\_flavor\_name) | OpenStack flavor used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | OpenStack image ID used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | OpenStack keypair name used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Id of OpenStack internal network used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Private key of ubuntu user on KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | OpenStack KYPO head security group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ip"></a> [cluster\_ip](#output\_cluster\_ip) | Floating IP address of KYPO kubernetes cluster instance |
| <a name="output_kubernetes_certificate"></a> [kubernetes\_certificate](#output\_kubernetes\_certificate) | Public key of Kubernetes user |
| <a name="output_kubernetes_private_key"></a> [kubernetes\_private\_key](#output\_kubernetes\_private\_key) | Private key of Kubernetes user |
<!-- END_TF_DOCS -->