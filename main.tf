
module "networking" {
  source = "./modules/networking"
  env    = "development"
}

module "instance" {
  source                      = "./modules/instance"
  ssh_key                     = module.ssh.public_key_openssh
  user                        = var.instance_user
  instance_ami                = var.instance_ami
  webserver_sg_id             = module.networking.webserver_sg_id
  public_subnet_ids           = module.networking.public_subnet_ids
  aws_internet_gateway        = module.networking.aws_internet_gateway
  aws_route_table             = module.networking.aws_route_table
  aws_route_table_association = module.networking.aws_route_table_association
}

module "ssh" {
  source = "./modules/ssh"
  env    = var.env
}

#==========================2nd phase install=================================#
module "application" {
  source = "./modules/application"
  image  = var.image
  host   = "ssh://${var.instance_user}@${module.instance.my_static_ips[0]}:22"
}
#==========================2nd phase install=================================#
