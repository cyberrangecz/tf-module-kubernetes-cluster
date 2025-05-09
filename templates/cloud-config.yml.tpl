#cloud-config
runcmd:
  - mkdir -p /var/lib/rancher/k3s/server/tls/
  - echo '${base64encode(kubernetes_ca[0].private_key_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/client-ca.key
  - echo '${base64encode(kubernetes_ca[1].private_key_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/server-ca.key
  - echo '${base64encode(kubernetes_ca[2].private_key_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/request-header-ca.key
  - echo '${base64encode(kubernetes_ca_certs[0].cert_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/client-ca.crt
  - echo '${base64encode(kubernetes_ca_certs[1].cert_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/server-ca.crt
  - echo '${base64encode(kubernetes_ca_certs[2].cert_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/request-header-ca.crt
  - echo '${base64encode(terraform_user.private_key_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/client-terraform-user.key
  - echo '${base64encode(terraform_user_certs.cert_pem)}' | base64 -d > /var/lib/rancher/k3s/server/tls/client-terraform-user.crt
  - apt update
  - apt install nfs-common -y
  - curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${k3s_version} sh -s -

write_files:
  - path: /etc/sysctl.d/99-cloud-init.conf
    content: |
      fs.inotify.max_user_instances=8192
      fs.inotify.max_user_watches=524288
  - path: /var/lib/rancher/k3s/server/manifests/traefik-config.yaml
    content: |
      apiVersion: helm.cattle.io/v1
      kind: HelmChartConfig
      metadata:
        name: traefik
        namespace: kube-system
      spec:
        valuesContent: |-
          additionalArguments:
            - "--log.level=INFO"
            - "--ping"
            - "--metrics.prometheus"

          deployment:
            kind: DaemonSet

          # no load balancer
          service:
            enabled: true
            type: ClusterIP

          # use host network for directly port listening
          hostNetwork: true

          ports:
            web:
              port: 80
              protocol: TCP
              exposedPort: 80
              redirectTo:
                port: websecure
            websecure:
              port: 443
              protocol: TCP
              exposedPort: 443
              tls:
                enabled: true
          updateStrategy:
            type: RollingUpdate
            rollingUpdate:
              maxUnavailable: 1
              maxSurge: null
          # run as root to 80 and 443 port listen permission
          securityContext:
            capabilities:
              add:
                - NET_BIND_SERVICE
            runAsNonRoot: false
            runAsUser: 0
