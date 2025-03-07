resource "google_dns_managed_zone" "dns-zone" {
  for_each = { for zone in var.dns-config : zone.name => zone }

  name     = each.value.name
  dns_name = each.value.dns-name
}

resource "google_dns_record_set" "dns-recordset" {
  for_each = { for entry in flatten([
    for zone in var.dns-config : [
      for sub in zone.subdomains : {
        zone_name = zone.name
        dns_name  = zone.dns-name
        subdomain = sub
      }
    ]
  ]) : "${entry.subdomain}.${entry.dns_name}" => entry }

  provider     = google-beta
  managed_zone = google_dns_managed_zone.dns-zone[each.value.zone_name].name
  name         = "${each.value.subdomain}.${each.value.dns_name}"
  type         = "A"
  rrdatas      = [google_compute_address.snapchain-tcp-ip.address, google_compute_address.snapchain-udp-ip.address]
  ttl          = 300
}