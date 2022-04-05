variable "external_network_name" {
  type        = string
  description = "External network name used for floating IP allocation"
}

variable "flavor_name" {
  type        = string
  description = "OpenStack flavor used by KYPO kubernetes cluster instance"
}

variable "image_id" {
  type        = string
  description = "OpenStack image ID used by KYPO kubernetes cluster instance"
}

variable "key_pair" {
  type        = string
  description = "OpenStack keypair name used by KYPO kubernetes cluster instance"
}

variable "network_id" {
  type        = string
  description = "Id of OpenStack internal network used by KYPO kubernetes cluster instance"
}

variable "private_key" {
  type        = string
  description = "Private key of ubuntu user on KYPO kubernetes cluster instance"
}

variable "security_group" {
  type        = string
  description = "OpenStack KYPO head security group"
}
