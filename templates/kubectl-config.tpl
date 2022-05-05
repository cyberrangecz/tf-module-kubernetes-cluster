apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://${server}:6443
  name: kypo
contexts:
- context:
    cluster: kypo
    namespace: kypo
    user: kypo
  name: kypo
current-context: kypo
kind: Config
preferences: {}
users:
- name: kypo
  user:
    client-certificate-data: ${client_certificate_data}
    client-key-data: ${client_key_data}
