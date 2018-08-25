output "prometheus" {
  value = "${module.observability.prometheus}"
}

output "alertmanager" {
  value = "${module.observability.alertmanager}"
}

output "grafana" {
  value = "${module.observability.grafana}"
}

output "pushgateway" {
  value = "${module.observability.pushgateway}"
}