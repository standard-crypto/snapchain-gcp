resource "kubernetes_config_map" "snapchain-config" {
  metadata {
    name = "${var.name}-config"
  }
  data = {
    "config.toml" = <<EOT
    rpc_address="0.0.0.0:3383"
    http_address="0.0.0.0:3381"
    rocksdb_dir="/home/node/app/.rocks"
    fc_network="Mainnet"
    read_node = true

    [statsd]
    prefix="snap_read"
    addr="127.0.0.1:8125"
    use_tags=false

    [gossip]
    address="/ip4/0.0.0.0/udp/3382/quic-v1"
    bootstrap_peers = "/ip4/54.236.164.51/udp/3382/quic-v1, /ip4/54.87.204.167/udp/3382/quic-v1, /ip4/44.197.255.20/udp/3382/quic-v1, /ip4/34.195.157.114/udp/3382/quic-v1, /ip4/107.20.169.236/udp/3382/quic-v1"

    [consensus]
    validator_addresses = ["6bc2d8901443de856d2670b0c2ea12b6727132fa830f9030d3a44ac5da9b1a72", "67474a42e0c6507198b73373b0558dfc94616b976ecfdf5c45fae11e2bee7102", "81032ecefa4260e5a63424f5a4b8b18b52d717a52583b3ffe22c4a7b084911b8", "2c0f58a364b7959c85e49b5a50d14d220c16f8bd7879b0d5d3f68b32de83ecb8", "29696eb40eb900a329a8d2542edef15d552c9ba6ded7882276be1e9eca090970"]
    shard_ids = [1,2]
    num_shards = 2

    [snapshot]
    endpoint_url = ""
    load_db_from_snapshot=false
    EOT
  }
}