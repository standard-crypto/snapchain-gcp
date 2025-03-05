resource "google_compute_disk" "snapchain" {
  name = "snapchain-data"
  type = "pd-ssd"
  zone = var.zone
}

resource "kubernetes_storage_class" "snapchain" {
  metadata {
    name = var.name
  }
  storage_provisioner    = "kubernetes.io/gce-pd"
  volume_binding_mode    = "Immediate"
  allow_volume_expansion = true
  reclaim_policy         = "Retain"
  parameters = {
    "type"             = "pd-ssd"
    "fstype"           = "ext4"
    "replication-type" = "none"
  }
}

resource "kubernetes_persistent_volume_claim" "snapchain" {
  metadata {
    name = var.name
  }
  spec {
    storage_class_name = kubernetes_storage_class.snapchain.metadata[0].name
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "100Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.snapchain.metadata.0.name
  }
}

resource "kubernetes_persistent_volume" "snapchain" {
  metadata {
    name = var.name
  }
  spec {
    capacity = {
      storage = "100Gi"
    }
    storage_class_name = kubernetes_storage_class.snapchain.metadata[0].name
    access_modes       = ["ReadWriteOnce"]
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.snapchain.name
        fs_type = "ext4"
      }
    }
  }
}