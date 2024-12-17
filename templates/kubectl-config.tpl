apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://${server}:6443
  name: ${workspace}
contexts:
- context:
    cluster: ${workspace}
    namespace: crczp
    user: ${workspace}
  name: ${workspace}
current-context: ${workspace}
kind: Config
preferences: {}
users:
- name: ${workspace}
  user:
    client-certificate-data: ${client_certificate_data}
    client-key-data: ${client_key_data}
