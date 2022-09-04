
output "public_ips" {
  value = module.instance.my_static_ips
}

output "vpc_cidr_block" {
  value = module.networking.vpc_cidr_blocks
}
