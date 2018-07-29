variable "profile" {}

variable "aws_credential_path" {
  default = "~/.aws/credentials"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "aws_ami" {
  default = "ami-5e8bb23b"
}

variable "aws_instance_type" {
  default = "t2.medium"
}

variable "key_name" {}

variable "user" {
  default = "ubuntu"
}

variable "private_ssh_key" {}

variable "cidr_blocks" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "outcidr_blocks" {
  type    = "list"
  default = ["0.0.0.0/0"]
}

variable "vpc_id" {}
