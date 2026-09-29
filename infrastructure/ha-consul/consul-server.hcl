datacenter = "dc-linode-prod"
data_dir   = "/opt/consul"
log_level  = "INFO"
server     = true
bootstrap_expect = 1          # Adjust based on your server node count (recommended 3 for production)

bind_addr  = "0.0.0.0"          # Local server IP address
client_addr = "0.0.0.0"

ui_config {
  enabled = true
}

connect {
  enabled = true
}