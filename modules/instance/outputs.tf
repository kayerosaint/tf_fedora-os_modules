
output "my_static_ips" {
  value = aws_eip.eip[*].public_ip
}
