resource "kubernetes_deployment" "snapchain" {
  metadata {
    name = var.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" = var.name
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = var.name
        }
      }
      spec {
        container {
          image = "farcasterxyz/snapchain:latest"
          name  = "${var.name}-container"
          resources {
            requests = {
              memory = "16Gi"
              cpu = "4"
            }
          }
          volume_mount {
            name       = "config-volume"
            mount_path = "/home/node/app/config.toml"
            sub_path   = "config.toml"
          }
          volume_mount {
            name       = var.name
            mount_path = "/home/node/app/.rocks"
          }
          port {
            name           = "http"
            protocol       = "TCP"
            container_port = 3381
          }
          port {
            name           = "gossip"
            protocol       = "UDP"
            container_port = 3382
          }
          port {
            name           = "rpc"
            protocol       = "TCP"
            container_port = 3383
          }
          env {
            name  = "RUST_BACKTRACE"
            value = "full"
          }
          command = ["./snapchain"]
          args    = ["--config-path", "/home/node/app/config.toml"]
        }
        volume {
          name = "config-volume"
          config_map {
            name = kubernetes_config_map.snapchain-config.metadata[0].name
          }
        }
        volume {
          name = var.name
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.snapchain.metadata[0].name
          }
        }
      }
    }
  }
  timeouts {
    create = "5m"
    update = "5m"
  }
}

resource "kubernetes_service" "snapchain-tcp" {
  metadata {
    name = "${var.name}-tcp"
    annotations = {
      "cloud.google.com/network-tier" = "Standard"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = var.name
    }
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 3381
      target_port = 3381
    }
    port {
      name        = "rpc"
      protocol    = "TCP"
      port        = 3383
      target_port = 3383
    }
    load_balancer_ip = google_compute_address.snapchain-tcp-ip.address
  }
}

resource "kubernetes_service" "snapchain-udp" {
  metadata {
    name = "${var.name}-udp"
    annotations = {
      "cloud.google.com/network-tier" = "Standard"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = var.name
    }
    port {
      name        = "gossip"
      protocol    = "UDP"
      port        = 3382
      target_port = 3382
    }
    load_balancer_ip = google_compute_address.snapchain-udp-ip.address
  }
}
