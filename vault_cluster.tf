# ============================================
# HashiCorp Cloud Platform (HCP) Vault Cluster
# ============================================



# Authentication via environment variables:
# export HCP_CLIENT_ID="your-service-principal-client-id"
# export HCP_CLIENT_SECRET="your-service-principal-client-secret"



# 2) HCP HVN (HashiCorp Virtual Network)
resource "hcp_hvn" "vault_hvn" {
  hvn_id         = "vault-hvn"
  cloud_provider = "aws"
  region         = "ap-southeast-1"
  cidr_block     = "192.168.0.0/20"
}

# 3) HCP Vault Cluster
resource "hcp_vault_cluster" "vault" {
  cluster_id      = "my-vault-cluster"
  hvn_id          = hcp_hvn.vault_hvn.hvn_id
  tier            = "dev" # Options: dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large
  public_endpoint = false # Set to false for private-only access

  # Optional: Specify Vault version
  # vault_version = "1.15.4"

  # Optional: Enable audit logs
  # audit_log_config {
  #   cloudwatch_group_name = "vault-audit-logs"
  # }
}

# 4) Admin token for initial access
resource "hcp_vault_cluster_admin_token" "admin_token" {
  cluster_id = hcp_vault_cluster.vault.cluster_id
}

# ============================================
# AWS Peering (Optional - for private access)
# ============================================

# 5) Your existing AWS VPC
data "aws_vpc" "frontend_vpc_sg" {
  id = aws_vpc.frontend_vpc_sg.id
  # Reference your existing VPC
  #id = "vpc-00ea790825aeae684" # Replace with your VPC ID
}

#6) HVN to AWS VPC Peering
resource "hcp_aws_network_peering" "peer" {
  hvn_id          = hcp_hvn.vault_hvn.hvn_id
  peering_id      = "vault-aws-peering"
  peer_vpc_id     = data.aws_vpc.frontend_vpc_sg.id
  peer_account_id = data.aws_vpc.frontend_vpc_sg.owner_id
  peer_vpc_region = "ap-southeast-1"
  #peer_vpc_cidr_block = data.aws_vpc.frontend_vpc_sg.cidr_block
}

# 7) Accept peering on AWS side
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
  auto_accept               = true
}

# 8) HVN route to AWS VPC
resource "hcp_hvn_route" "vault_to_aws" {
  hvn_link         = hcp_hvn.vault_hvn.self_link
  hvn_route_id     = "vault-to-aws-route"
  destination_cidr = data.aws_vpc.frontend_vpc_sg.cidr_block
  target_link      = hcp_aws_network_peering.peer.self_link
}

# 9) AWS route back to HVN
resource "aws_route" "aws_to_hvn" {
  route_table_id            = data.aws_vpc.frontend_vpc_sg.main_route_table_id
  destination_cidr_block    = hcp_hvn.vault_hvn.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.id
}

# ============================================
# Outputs
# ============================================

output "vault_cluster_id" {
  value       = hcp_vault_cluster.vault.cluster_id
  description = "HCP Vault Cluster ID"
}

output "vault_public_url" {
  value       = hcp_vault_cluster.vault.vault_public_endpoint_url
  description = "Public URL to access Vault UI"
}

output "vault_private_url" {
  value       = hcp_vault_cluster.vault.vault_private_endpoint_url
  description = "Private URL to access Vault (requires VPC peering)"
}

output "vault_namespace" {
  value       = hcp_vault_cluster.vault.namespace
  description = "Default namespace (usually 'admin')"
}

output "vault_admin_token" {
  value       = hcp_vault_cluster_admin_token.admin_token.token
  sensitive   = true
  description = "Initial admin token (save this securely!)"
}

# output "connection_info" {
#   value = <<-EOT

#     ============================================
#     HCP Vault Cluster Created!
#     ============================================

#     Cluster ID: ${hcp_vault_cluster.vault.cluster_id}
#     Public URL: ${hcp_vault_cluster.vault.vault_public_endpoint_url}
#     Namespace:  ${hcp_vault_cluster.vault.namespace}

#     To connect:
#     1. Get admin token: terraform output -raw vault_admin_token
#     2. Set environment:
#        export VAULT_ADDR="${hcp_vault_cluster.vault.vault_public_endpoint_url}"
#        export VAULT_NAMESPACE="${hcp_vault_cluster.vault.namespace}"
#        export VAULT_TOKEN="<admin-token>"
#     3. Test: vault status

#     ============================================
#   EOT
# }