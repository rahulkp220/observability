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
