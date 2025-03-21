data "google_client_config" "default" {}

module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google"
  version                = "30.0.0"
  project_id             = var.project-id
  name                   = "${var.name}-cluster"
  region                 = var.region
  network                = module.gcp-network.network_name
  subnetwork             = local.subnet_names[index(module.gcp-network.subnets_names, local.subnet-name)]
  ip_range_pods          = local.ip-range-pods-name
  ip_range_services      = local.ip-range-services-name
  release_channel        = "REGULAR"
  maintenance_recurrence = "FREQ=DAILY"

  node_pools = [
    {
      name            = "${var.name}-node-pool"
      machine_type    = "c3-standard-8"
      node_locations  = var.zone
      min_count       = 1
      max_count       = 1
      local_ssd_count = 0
      spot            = false
      disk_size_gb    = 30
      disk_type       = "pd-ssd"
      image_type      = "COS_CONTAINERD"
      enable_gcfs     = false
      enable_gvnic    = false
      auto_repair     = true
      auto_upgrade    = true
      preemptible     = false
    }
  ]
  node_pools_tags = {
    all = [
      var.name,
    ]
  }
}