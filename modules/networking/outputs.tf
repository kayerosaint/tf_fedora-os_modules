

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_cidr_blocks" {
  value = try(data.aws_vpc.dev_vpc[*].cidr_block, "")
}

output "webserver_sg_id" {
  value = aws_security_group.my_webserver.id
}
