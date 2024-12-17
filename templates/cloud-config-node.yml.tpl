#cloud-config
runcmd:
  - apt update
  - apt install nfs-common -y
  - curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${k3s_version} K3S_RESOLV_CONF=/run/systemd/resolve/resolv.conf K3S_TOKEN=${secret} INSTALL_K3S_EXEC="${k3s_exec_options}" K3S_URL=https://${first_node}:6443 sh -s -

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
              expose: true
              protocol: TCP
              exposePort: 80
              redirectTo:
                port: websecure
            websecure:
              port: 443
              expose: true
              protocol: TCP
              exposePort: 443
              tls:
                enable: true
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
