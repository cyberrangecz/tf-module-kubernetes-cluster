data "openstack_networking_network_v2" "network" {
  name = var.external_network_name
}

resource "openstack_lb_loadbalancer_v2" "lb" {
  count          = var.ha ? 1 : 0
  name           = "${terraform.workspace}-kubernetes-cluster"
  vip_network_id = data.openstack_networking_network_v2.network.id
}

#resource "openstack_lb_listener_v2" "listener_80" {
#  count           = var.ha ? 1 : 0
#  name            = "${terraform.workspace}-kubernetes-cluster-443"
#  protocol        = "HTTP"
#  protocol_port   = 80
#  loadbalancer_id = openstack_lb_loadbalancer_v2.lb[0].id
#}
#
#resource "openstack_lb_pool_v2" "pool_80" {
#  count       = var.ha ? 1 : 0
#  name        = "${terraform.workspace}-kubernetes-cluster-443"
#  protocol    = "HTTP"
#  lb_method   = "ROUND_ROBIN"
#  listener_id = openstack_lb_listener_v2.listener_80[0].id
#}
#
#resource "openstack_lb_members_v2" "members_80" {
#  count   = var.ha ? 1 : 0
#  pool_id = openstack_lb_pool_v2.pool_80[0].id
#
#  member {
#    address       = openstack_compute_instance_v2.node_first[0].access_ip_v4
#    protocol_port = 80
#  }
#
#  member {
#    address       = openstack_compute_instance_v2.node_add[0].access_ip_v4
#    protocol_port = 80
#  }
#
#  member {
#    address       = openstack_compute_instance_v2.node_add[1].access_ip_v4
#    protocol_port = 80
#  }
#}

resource "openstack_lb_listener_v2" "listener_443" {
  count           = var.ha ? 1 : 0
  name            = "${terraform.workspace}-kubernetes-cluster-443"
  protocol        = "HTTPS"
  protocol_port   = 443
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb[0].id
}

resource "openstack_lb_pool_v2" "pool_443" {
  count       = var.ha ? 1 : 0
  name        = "${terraform.workspace}-kubernetes-cluster-443"
  protocol    = "HTTPS"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener_443[0].id
}

resource "openstack_lb_members_v2" "members_443" {
  count   = var.ha ? 1 : 0
  pool_id = openstack_lb_pool_v2.pool_443[0].id

  member {
    address       = openstack_compute_instance_v2.node_first[0].access_ip_v4
    protocol_port = 443
  }

  member {
    address       = openstack_compute_instance_v2.node_add[0].access_ip_v4
    protocol_port = 443
  }

  member {
    address       = openstack_compute_instance_v2.node_add[1].access_ip_v4
    protocol_port = 443
  }
}
