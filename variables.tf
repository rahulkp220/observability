variable "profile" {}
variable "aws_credential_path" {}

variable "aws_region" {}

variable "aws_ami" {}

variable "prometheus_count" {}

variable "alertmanager_count" {}

variable "grafana_count" {}

variable "pushgateway_count" {}

variable "aws_instance_type" {}

variable "key_name" {}

variable "user" {}

variable "private_ssh_key" {}

variable "cidr_blocks" {
  type    = "list"
  }

variable "outcidr_blocks" {
  type    = "list"
}

variable "vpc_id" {}

variable "has_public_ip" {}
