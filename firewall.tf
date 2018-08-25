resource "aws_security_group" "prometheus_sg" {
  name   = "prometheus_sg"
  vpc_id = "${var.vpc_id}"
  count = "${var.prometheus_count > 0 ? 1 : 0}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "SSH"
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Prometheus"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.outcidr_blocks}"
  }
}

resource "aws_security_group" "alertmanager_sg" {
  name   = "alertmanager_sg"
  vpc_id = "${var.vpc_id}"
  count = "${var.alertmanager_count > 0 ? 1 : 0}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "SSH"
  }

  ingress {
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Alertmanager"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.outcidr_blocks}"
  }
}

resource "aws_security_group" "grafana_sg" {
  name   = "grafana_sg"
  vpc_id = "${var.vpc_id}"
  count = "${var.grafana_count > 0 ? 1 : 0}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "SSH"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "Grafana"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.outcidr_blocks}"
  }
}

resource "aws_security_group" "pushgateway_sg" {
  name   = "pushgateway_sg"
  vpc_id = "${var.vpc_id}"
  count = "${var.pushgateway_count > 0 ? 1 : 0}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "SSH"
  }

  ingress {
    from_port   = 9091
    to_port     = 9091
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
    description = "PushGateway"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.outcidr_blocks}"
  }
}
