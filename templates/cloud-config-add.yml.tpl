#cloud-config
runcmd:
  - mkdir -p /var/opt/kypo/kypo-ansible-runner-volumes
  - apt update
  - apt install nfs-common -y
  - curl -sfL https://get.k3s.io | K3S_RESOLV_CONF=/run/systemd/resolve/resolv.conf K3S_TOKEN=${secret} INSTALL_K3S_EXEC="server" K3S_URL=https://${first_node}:6443 sh -s -

write_files:
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
              expose: true
              protocol: TCP
              exposePort: 80
              redirectTo: websecure
            websecure:
              port: 443
              expose: true
              protocol: TCP
              exposePort: 443
              tls:
                enable: true

          # run as root to 80 and 443 port listen permission
          securityContext:
            capabilities:
              add:
                - NET_BIND_SERVICE
            runAsNonRoot: false
            runAsUser: 0
