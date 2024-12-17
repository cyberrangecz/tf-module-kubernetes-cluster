variable "agent_count" {
  type        = number
  description = "Number of Kubernetes worker nodes"
  default     = 3
}

variable "agent_flavor_name" {
  type        = string
  description = "OpenStack flavor used by kubernetes cluster agent instance in HA mode"
  default     = "standard.medium"
}

variable "external_network_name" {
  type        = string
  description = "External network name used for floating IP allocation"
}

variable "flavor_name" {
  type        = string
  description = "OpenStack flavor used by kubernetes cluster instance"
}

variable "ha" {
  type        = bool
  description = "Deploy cluster with 3 nodes in HA"
  default     = false
}

variable "image_id" {
  type        = string
  description = "OpenStack image ID used by kubernetes cluster instance"
}

variable "k3s_version" {
  type        = string
  description = "Version of k3s distribution"
  default     = "v1.31.4+k3s1"
}

variable "key_pair" {
  type        = string
  description = "OpenStack keypair name used by kubernetes cluster instance"
}

variable "network_id" {
  type        = string
  description = "Id of OpenStack internal network used by kubernetes cluster instance"
}

variable "os_volume" {
  type    = bool
  default = false
}

variable "os_volume_size" {
  type    = number
  default = 80
}

variable "private_key" {
  type        = string
  description = "Private key of ubuntu user on kubernetes cluster instance"
}

variable "proxy_host" {
  type        = string
  description = "FQDN/IP address of proxy jump host. Set only for HA setup."
  default     = ""
}

variable "security_group" {
  type        = string
  description = "OpenStack head security group"
}

variable "server_count" {
  type        = number
  description = "Number of Kubernetes server nodes"
  default     = 3
}

variable "server_flavor_name" {
  type        = string
  description = "OpenStack flavor used by kubernetes cluster server instance in HA mode"
  default     = "standard.large"
}

variable "subnet_name" {
  type        = string
  description = "OpenStack subnet name for LB"
  default     = "base-subnet"
}
