output "address" {
  value = data.template_file.alertmanager_dns_name.rendered
}