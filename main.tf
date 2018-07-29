provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credential_path}"
  profile                 = "${var.profile}"
}

resource "aws_security_group" "machine_sg" {
  name   = "machine_sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "SSH"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Nginx"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Django"
  }

  ingress {
    from_port   = 8050
    to_port     = 8050
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Logstash"
  }

  ingress {
    from_port   = 8020
    to_port     = 8020
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Elasticsearch"
  }

  ingress {
    from_port   = 8056
    to_port     = 8056
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Kibana"
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Prometheus"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Grafana"
  }

  ingress {
    from_port   = 9411
    to_port     = 9411
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Zipkin"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.outcidr_blocks}"
  }
}

resource "aws_instance" "machine" {
  count                       = 1
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.machine_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true

  tags {
    Name = "machine"
  }

  connection {
    user        = "${var.user}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable \"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce python3-pip",
      "sudo service docker start",
      "sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "cat ~/.ssh/authorized_keys | tail -1 >> ~/.ssh/id_rsa.pub",
      "git clone https://github.com/mStakx/observability-boilerplate1.git",
      "cd observability-boilerplate1",
      "sed -i \"1icython\" requirements.txt",
      "sudo sysctl -w vm.max_map_count=262144",
      "sudo ./setup.sh",
    ]
  }
}
