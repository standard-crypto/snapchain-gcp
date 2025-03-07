output "kubernetes_endpoint" {
  description = "The cluster endpoint"
  sensitive   = true
  value       = module.gke.endpoint
}

output "cluster_name" {
  description = "Cluster name"
  value       = module.gke.name
}

output "location" {
  value = module.gke.location
}

output "master_kubernetes_version" {
  description = "Kubernetes version of the master"
  value       = module.gke.master_version
}

output "service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = module.gke.service_account
}

output "network_name" {
  description = "The name of the VPC being created"
  value       = module.gcp-network.network_name
}

output "subnet_names" {
  description = "The names of the subnet being created"
  value       = module.gcp-network.subnets_names
}

output "region" {
  description = "The region in which the cluster resides"
  value       = module.gke.region
}

output "zones" {
  description = "List of zones in which the cluster resides"
  value       = module.gke.zones
}

output "project_id" {
  description = "The project ID the cluster is in"
  value       = var.project-id
}

output "http-rpc-ip" {
  description = "The http/rpc IP address for the snapchain node"
  value       = google_compute_address.snapchain-tcp-ip.address
}

output "gossip-ip" {
  description = "The gossip IP address for the running snapchain node"
  value       = google_compute_address.snapchain-udp-ip.address
}

output "node-url" {
  description = "The URL for the running snapchain node"
  value       = var.enable_dns ? google_dns_record_set.dns-recordset["enabled"].name : null
}