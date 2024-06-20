<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.kubectl_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.provision_cluster](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provision_initial_server](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [openstack_compute_floatingip_associate_v2.kubernetes_cluster_fip_association](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_floatingip_associate_v2) | resource |
| [openstack_compute_instance_v2.kubernetes_cluster](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_compute_instance_v2.node_agent](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_compute_instance_v2.node_initial_server](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_compute_instance_v2.node_server](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2) | resource |
| [openstack_compute_servergroup_v2.server_group](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_servergroup_v2) | resource |
| [openstack_lb_listener_v2.listener_443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_listener_v2) | resource |
| [openstack_lb_listener_v2.listener_515](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_listener_v2) | resource |
| [openstack_lb_listener_v2.listener_6443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_listener_v2) | resource |
| [openstack_lb_listener_v2.listener_80](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_listener_v2) | resource |
| [openstack_lb_loadbalancer_v2.lb](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_loadbalancer_v2) | resource |
| [openstack_lb_members_v2.members_443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_members_v2) | resource |
| [openstack_lb_members_v2.members_515](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_members_v2) | resource |
| [openstack_lb_members_v2.members_6443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_members_v2) | resource |
| [openstack_lb_members_v2.members_80](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_members_v2) | resource |
| [openstack_lb_monitor_v2.monitor_443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_monitor_v2) | resource |
| [openstack_lb_monitor_v2.monitor_515](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_monitor_v2) | resource |
| [openstack_lb_monitor_v2.monitor_6443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_monitor_v2) | resource |
| [openstack_lb_monitor_v2.monitor_80](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_monitor_v2) | resource |
| [openstack_lb_pool_v2.pool_443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_pool_v2) | resource |
| [openstack_lb_pool_v2.pool_515](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_pool_v2) | resource |
| [openstack_lb_pool_v2.pool_6443](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_pool_v2) | resource |
| [openstack_lb_pool_v2.pool_80](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/lb_pool_v2) | resource |
| [openstack_networking_floatingip_v2.kubernetes_cluster_fip](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_v2) | resource |
| [random_password.token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_cert_request.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.kubernetes_ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.terraform_user](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.kubernetes_ca_certs](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [openstack_networking_network_v2.network](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_network_v2) | data source |
| [openstack_networking_secgroup_v2.head_sg](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_secgroup_v2) | data source |
| [openstack_networking_subnet_v2.subnet](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/data-sources/networking_subnet_v2) | data source |
| [template_file.cloud_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cloud_config_agent](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cloud_config_initial_server](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.cloud_config_server](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_count"></a> [agent\_count](#input\_agent\_count) | Number of Kubernetes worker nodes | `number` | `3` | no |
| <a name="input_agent_flavor_name"></a> [agent\_flavor\_name](#input\_agent\_flavor\_name) | OpenStack flavor used by KYPO kubernetes cluster agent instance in HA mode | `string` | `"standard.medium"` | no |
| <a name="input_external_network_name"></a> [external\_network\_name](#input\_external\_network\_name) | External network name used for floating IP allocation | `string` | n/a | yes |
| <a name="input_flavor_name"></a> [flavor\_name](#input\_flavor\_name) | OpenStack flavor used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_ha"></a> [ha](#input\_ha) | Deploy cluster with 3 nodes in HA | `bool` | `false` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | OpenStack image ID used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | Version of k3s distribution | `string` | `"v1.27.9+k3s1"` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | OpenStack keypair name used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Id of OpenStack internal network used by KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_os_volume"></a> [os\_volume](#input\_os\_volume) | n/a | `bool` | `false` | no |
| <a name="input_os_volume_size"></a> [os\_volume\_size](#input\_os\_volume\_size) | n/a | `number` | `80` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Private key of ubuntu user on KYPO kubernetes cluster instance | `string` | n/a | yes |
| <a name="input_proxy_host"></a> [proxy\_host](#input\_proxy\_host) | FQDN/IP address of proxy-jump host. Set only for HA setup. | `string` | `""` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | OpenStack KYPO head security group | `string` | n/a | yes |
| <a name="input_server_count"></a> [server\_count](#input\_server\_count) | Number of Kubernetes server nodes | `number` | `3` | no |
| <a name="input_server_flavor_name"></a> [server\_flavor\_name](#input\_server\_flavor\_name) | OpenStack flavor used by KYPO kubernetes cluster server instance in HA mode | `string` | `"standard.large"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | OpenStack subnet name for LB | `string` | `"kypo-base-subnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_ip"></a> [agent\_ip](#output\_agent\_ip) | Internal IPs of the agent nodes in HA setup |
| <a name="output_cluster_ip"></a> [cluster\_ip](#output\_cluster\_ip) | Floating IP address of KYPO kubernetes cluster instance |
| <a name="output_kubernetes_certificate"></a> [kubernetes\_certificate](#output\_kubernetes\_certificate) | Public key of Kubernetes user |
| <a name="output_kubernetes_private_key"></a> [kubernetes\_private\_key](#output\_kubernetes\_private\_key) | Private key of Kubernetes user |
| <a name="output_node_0_ip"></a> [node\_0\_ip](#output\_node\_0\_ip) | Internal IP of the first node in HA setup |
| <a name="output_server_ip"></a> [server\_ip](#output\_server\_ip) | Internal IPs of the server nodes in HA setup |
<!-- END_TF_DOCS -->
