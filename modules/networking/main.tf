
#=====================security group=====================#

data "aws_vpc" "dev_vpc" {
  tags = {
    Name = "dev"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  vpc_id      = data.aws_vpc.dev_vpc.id
  description = "tcp/http/icmp"


  dynamic "ingress" {

    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "web server"
    Owner = "MaksK"
  }
}

#==================Create Subnet=======================#

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = data.aws_vpc.dev_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-${count.index + 1}"
  }
}

#=====================IGW,Routing=======================#

resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.dev_vpc.id
  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_route_table" "public_subnets" {
  count  = length(var.public_subnet_cidrs)
  vpc_id = data.aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = element(aws_route_table.public_subnets[*].id, count.index)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
