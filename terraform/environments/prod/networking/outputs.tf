output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.prod_vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.prod_vpc.vpc_cidr_block
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.prod_vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.prod_vpc.private_subnet_id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = module.prod_vpc.igw_id
}

output "public_route_table_id" {
  description = "Route table for public subnet"
  value       = module.prod_vpc.public_route_table_id
}

