resource "kubernetes_config_map" "snapchain-config" {
  metadata {
    name = "${var.name}-config"
  }
  data = {
    "config.toml" = <<EOT
    rpc_address="0.0.0.0:3383"
    http_address="0.0.0.0:3381"
    rocksdb_dir="/home/node/app/.rocks"
    fc_network="Testnet"
    read_node = true

    [statsd]
    prefix="snap_read"
    addr="127.0.0.1:8125"
    use_tags=false

    [gossip]
    address="/ip4/0.0.0.0/udp/3382/quic-v1"
    bootstrap_peers = "/ip4/52.21.4.237/udp/3382/quic-v1, /ip4/3.219.203.198/udp/3382/quic-v1, /ip4/52.73.172.10/udp/3382/quic-v1, /ip4/98.85.82.165/udp/3382/quic-v1, /ip4/3.208.115.198/udp/3382/quic-v1"

    [consensus]
    validator_addresses = ["b5a20adf31d58c6480cc46e6c1cba5e13396228a465a7f9fd34d2bb665cc68a5", "5891673de56bf78bf6b407186408e47f536a69ee586c7bdcee5c9e302cc350f0", "eed6c603cffd1d8225bc11beaeeea05c6a117d22cfcd9d7ae1b2907868d5cb0b", "07438a6f720da32a69dc43b952e5407254884fe8cebc474a32f639ff57a23e01", "102da10a60dc0b74c74f8072f925c6beadecfed70f265be122e01a7076f33bc9"]
    shard_ids = [1,2]
    num_shards = 2

    [snapshot]
    endpoint_url = ""
    load_db_from_snapshot=false
    EOT
  }
}