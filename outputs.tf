output "prometheus" {
  value = "${aws_instance.prometheus.*.public_ip}"
}

output "alertmanager" {
  value = "${aws_instance.alertmanager.*.public_ip}"
}

output "grafana" {
  value = "${aws_instance.grafana.*.public_ip}"
}

output "pushgateway" {
  value = "${aws_instance.pushgateway.*.public_ip}"
}