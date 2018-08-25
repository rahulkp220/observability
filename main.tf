resource "aws_instance" "prometheus" {
  count                       = "${var.prometheus_count}"
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.prometheus_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

  tags {
    Name = "prometheus-${format("%d", count.index+1)}"
  }

  connection {
    user        = "${var.user}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "file" {
    source      = "../scripts/prometheus.sh"
    destination = "/tmp/prometheus.sh"
  }


  provisioner "file" {
    source      = "../scripts/node_exporter.sh"
    destination = "/tmp/node_exporter.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "chmod +x /tmp/prometheus.sh",
      "sudo sh /tmp/prometheus.sh",
      "chmod +x /tmp/node_exporter.sh",
      "sudo sh /tmp/node_exporter.sh"
    ]
  }
}

resource "aws_instance" "alertmanager" {
  count                       = "${var.alertmanager_count}"
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.alertmanager_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

  tags {
    Name = "alertmanager-${format("%d", count.index+1)}"
  }

  connection {
    user        = "${var.user}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "file" {
    source      = "../scripts/alertmanager.sh"
    destination = "/tmp/alertmanager.sh"
  }

  provisioner "file" {
    source      = "../scripts/node_exporter.sh"
    destination = "/tmp/node_exporter.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "chmod +x /tmp/alertmanager.sh",
      "sudo sh /tmp/alertmanager.sh",,
      "chmod +x /tmp/node_exporter.sh",
      "sudo sh /tmp/node_exporter.sh"
    ]
  }
}

resource "aws_instance" "grafana" {
  count                       = "${var.grafana_count}"
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.grafana_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

  tags {
    Name = "grafana-${format("%d", count.index+1)}"
  }

  connection {
    user        = "${var.user}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "file" {
    source      = "../scripts/grafana.sh"
    destination = "/tmp/grafana.sh"
  }

  provisioner "file" {
    source      = "../scripts/node_exporter.sh"
    destination = "/tmp/node_exporter.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "chmod +x /tmp/grafana.sh",
      "sudo sh /tmp/grafana.sh",,
      "chmod +x /tmp/node_exporter.sh",
      "sudo sh /tmp/node_exporter.sh"
    ]
  }
}

resource "aws_instance" "pushgateway" {
  count                       = "${var.pushgateway_count}"
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.pushgateway_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

  tags {
    Name = "pushGateway-${format("%d", count.index+1)}"
  }

  connection {
    user        = "${var.user}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "file" {
    source      = "../scripts/node_exporter.sh"
    destination = "/tmp/node_exporter.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "sudo apt-get install -y prometheus-pushgateway",,
      "chmod +x /tmp/node_exporter.sh",
      "sudo sh /tmp/node_exporter.sh"
    ]
  }
}

