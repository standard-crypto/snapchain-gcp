# Google Cloud Project ID
project-id = "gcp-project-id"

# Region where the resources will be deployed
region = "us-west1"

# Specific zone within the region
zone = "us-west1-b"

# Name prefix for all resources
name = "snapchain"

# Optional DNS config
dns-config = [
  {
    name       = "dot-vc-farcaster-dns-zone"
    dns-name   = "farcaster.standardcrypto.vc."
    subdomains = ["snapchain"]
  },
  {
    name       = "farcaster-dns-zone"
    dns-name   = "farcaster.standardcryptovc.com."
    subdomains = ["snapchain"]
  }
]