variable "aws_region" {
  default = "eu-west-1"
}

variable "vpc_cdir" {
  description = "CIDR for VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CDIR for the public subnet"
  default = "10.0.0.0/24"
}

variable "ami" {
  description = "Centos"
  default = "ami-0d063c6b"
}