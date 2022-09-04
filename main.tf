
module "networking" {
  source = "./modules/networking"
  env    = "development"
}

module "instance" {
  source            = "./modules/instance"
  ssh_key           = var.instance_key_file
  user              = var.instance_user
  instance_ami      = var.instance_ami
  webserver_sg_id   = module.networking.webserver_sg_id
  public_subnet_ids = module.networking.public_subnet_ids
}
#==========================2nd phase install=================================#
module "application" {
  source = "./modules/application"
  image  = var.image
  host   = "ssh://${var.instance_user}@${module.instance.my_static_ips[0]}:22"
}
#==========================2nd phase install=================================#
