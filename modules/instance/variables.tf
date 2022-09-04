
variable "ssh_key" {
  description = "public key path"
  type        = string
}

variable "instance_ami" {
  description = "AWS AMI"
  type        = string
}

variable "user" {
  description = "instance user"
  type        = string
}

variable "env" {
  default = "development"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.8.0/24",
    "10.0.9.0/24",
  ]
}

variable "webserver_sg_id" {
  description = "EC2 security group id"
  type        = string
}

variable "public_subnet_ids" {}





variable "aws_internet_gateway" {}

variable "aws_route_table" {}

variable "aws_route_table_association" {}
