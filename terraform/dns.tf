resource "google_dns_managed_zone" "dns-zone" {
  for_each = var.enable_dns ? { "enabled" = true } : {} # Only create if enable_dns = true
  name     = "dot-vc-farcaster-dns-zone"
  dns_name = "${var.dns-name}."
}


resource "google_dns_record_set" "dns-recordset" {
  for_each     = var.enable_dns ? { "enabled" = true } : {} # Only create if enable_dns = true
  provider     = google-beta
  managed_zone = google_dns_managed_zone.dns-zone["enabled"].name
  name         = "${var.subdomain}.${google_dns_managed_zone.dns-zone["enabled"].dns_name}"
  type         = "A"
  rrdatas      = [google_compute_address.snapchain-tcp-ip.address, google_compute_address.snapchain-udp-ip.address]
  ttl          = 300
}