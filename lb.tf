data "openstack_networking_network_v2" "network" {
  name = var.external_network_name
}

data "openstack_networking_secgroup_v2" "head_sg" {
  name = var.security_group
}

data "openstack_networking_subnet_v2" "subnet" {
  name = "kypo-base-subnet"
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  count              = var.ha ? 1 : 0
  name               = "${terraform.workspace}-kubernetes-cluster"
  vip_network_id     = data.openstack_networking_network_v2.network.id
  security_group_ids = [data.openstack_networking_secgroup_v2.head_sg.id]
}

resource "openstack_lb_listener_v2" "listener_80" {
  count           = var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-cluster-80"
  protocol        = "TCP"
  protocol_port   = 80
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb[0].id
}

resource "openstack_lb_pool_v2" "pool_80" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-80"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener_80[0].id
}

resource "openstack_lb_members_v2" "members_80" {
  count   = var.ha ? 1 : 0
  pool_id = openstack_lb_pool_v2.pool_80[0].id

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-80-1"
    address       = openstack_compute_instance_v2.node_first[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 80
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-80-2"
    address       = openstack_compute_instance_v2.node_add[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 80
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-80-3"
    address       = openstack_compute_instance_v2.node_add[1].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 80
  }
}

resource "openstack_lb_monitor_v2" "monitor_80" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-80"
  pool_id     = openstack_lb_pool_v2.pool_80[0].id
  type        = "TCP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

resource "openstack_lb_listener_v2" "listener_443" {
  count           = var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-cluster-443"
  protocol        = "TCP"
  protocol_port   = 443
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb[0].id
}

resource "openstack_lb_pool_v2" "pool_443" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-443"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener_443[0].id
}

resource "openstack_lb_members_v2" "members_443" {
  count   = var.ha ? 1 : 0
  pool_id = openstack_lb_pool_v2.pool_443[0].id

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-443-1"
    address       = openstack_compute_instance_v2.node_first[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 443
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-443-2"
    address       = openstack_compute_instance_v2.node_add[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 443
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-443-3"
    address       = openstack_compute_instance_v2.node_add[1].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 443
  }
}

resource "openstack_lb_monitor_v2" "monitor_443" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-443"
  pool_id     = openstack_lb_pool_v2.pool_443[0].id
  type        = "TCP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

resource "openstack_lb_listener_v2" "listener_6443" {
  count           = var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-cluster-6443"
  protocol        = "TCP"
  protocol_port   = 6443
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb[0].id
}

resource "openstack_lb_pool_v2" "pool_6443" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-6443"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener_6443[0].id
}

resource "openstack_lb_members_v2" "members_6443" {
  count   = var.ha ? 1 : 0
  pool_id = openstack_lb_pool_v2.pool_6443[0].id

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-6443-1"
    address       = openstack_compute_instance_v2.node_first[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 6443
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-6443-2"
    address       = openstack_compute_instance_v2.node_add[0].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 6443
  }

  member {
    name          = "${terraform.workspace}-kubernetes-cluster-6443-3"
    address       = openstack_compute_instance_v2.node_add[1].access_ip_v4
    subnet_id     = data.openstack_networking_subnet_v2.subnet.id
    protocol_port = 6443
  }
}

resource "openstack_lb_monitor_v2" "monitor_6443" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-6443"
  pool_id     = openstack_lb_pool_v2.pool_6443[0].id
  type        = "TCP"
  delay       = 20
  timeout     = 10
  max_retries = 5
}
