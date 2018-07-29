resource "aws_instance" "machine" {
  count                       = "${var.machine_count}"
  ami                         = "${var.aws_ami}"
  instance_type               = "${var.aws_instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.machine_sg.id}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.has_public_ip}"

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
