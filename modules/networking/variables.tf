
variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list(any)
  default     = ["80", "443", "22"]
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
