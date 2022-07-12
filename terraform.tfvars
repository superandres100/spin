// AWS PROVDER ---- Add your login information

region     = "us-east-1"
access_key = "AKIARVVM2BQJQCL3U6YT"
secret_key = "nBgtyoSu0FC4a6uM7oa38LncVCFnSletlPFMl42L"


// --- VPC Network Configuration --- Add your VPC-id and IGW-id for Prod VPC
cidr_block = "172.20.4.64/27"
vpc_id = "vpc-03a7dae813af25efb"
igw_id = "igw-017b9aaa021a579fc"
public_subnets_map = {
  "us-east-1a" = 0
  "us-east-1b" = 1
  }
 subnets_bit_length = 1
 
 // ----Endpoint Information --- Add the endpoint service name
 
 service_name = "com.amazonaws.vpce.us-east-1.vpce-svc-09f5d87b88509e545"