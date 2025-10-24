# Default provider — Singapore
provider "aws" {
  region = "ap-southeast-1"
}

# # Aliased provider — Tokyo
# provider "aws" {
#   alias  = "tokyo"
#   region = "ap-northeast-1"
# }

provider "hcp" {
  project_id    = "00a4edd5-877a-4cc4-acfe-4f9c2fc2367f"
  client_secret = "7OxjQPJTL95d3gLXA8N2STckIgOdicW7V00hNXeM0iok3EjekMcvrE1pr2YsIaWo"
  client_id     = "hosKXhWo9MPezHDmhwgu4ppd8MOmq5tz"
}