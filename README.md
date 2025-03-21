# Snapchain-GCP

This repo has config for deploying a snapchain read node to GCP with kubernetes and terraform. This is in development and more updates will follow to run a full node and participate in the network.

The configuration comes from the [instructions]https://github.com/farcasterxyz/snapchain?tab=readme-ov-file#running-a-node) to run a node.

## Outputs

- VPC
- Firewall
- K8s Cluster
- K8s Deployment running snapchain node
- Persistent disk storage for snapchain rocks db
- K8s Service and IP address for snapchain HTTP & RPC (3381 & 3383)
- K8s Service and IP address for snapchain gossip (3382)
- GCP DNS Zone & DNS Record (optional)

## Steps to Deploy

### Prerequisites

1. Have a Google Cloud account
2. Have a Terraform account
3. Own a top level domain name (optional)

### Setup / Config

1. Create a Terraform workspace
2. Update [`terraform/backend.tf`](./terraform/backend.tf) with your Terraform org and workspace
3. Authenticate Terraform with GCP ([guide](https://cloud.google.com/docs/terraform/authentication))
4. Create `terraform.tfvars` and fill in the values from [`example.terraform.tfvars`](./terraform/example.terraform.tfvars)
5. Run `cd terraform & terraform init`

### Deploying

1. Ensure the config in [`snapchain-config.tf`](./terraform/snapchain-config.tf) is correct (current config comes from [farcasterxyz/snapchain/docker-compose.read.yml](https://github.com/farcasterxyz/snapchain/blob/main/docker-compose.read.yml))
2. Run `cd terraform & terraform apply`

### DNS (optional)
Once finished, point your top level domain to the NameServers of DNS zone created.