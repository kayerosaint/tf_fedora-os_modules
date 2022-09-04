variable "region" {
  description = "aws region"
  type        = string
}

variable "image" {
  description = "container image you will run on the instance"
  type        = string
}

variable "instance_key_file" {
  description = "public key path"
  type        = string
}

variable "instance_ami" {
  description = "AWS AMI"
  type        = string
}

variable "instance_user" {
  description = "instance user"
  type        = string
}
