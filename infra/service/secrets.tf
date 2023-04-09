locals {
  env_file_object_key = "alertmanager/service/environments/${var.instance}.env"
  configuration_file_object_path = "alertmanager/service/configuration/alertmanager.yml"

  env_file_object_path = "s3://${var.secrets_bucket_name}/${local.env_file_object_key}"
  configuration_file_object_path = "s3://${var.secrets_bucket_name}/${local.configuration_file_object_path}"

  alertmanager_cluster_peers = join(",", [
    for peer in setsubtract(range(1, var.cluster_size + 1), [tostring(var.instance)]):
          "${var.service_name}-${peer}.${var.service_registry_namespace}.${var.domain_name}:${var.alertmanager_service_host_cluster_port}"
  ])
  alertmanager_dns_name = "${var.component}-${var.deployment_identifier}.${data.terraform_remote_state.domain.outputs.domain_name}"

  env = templatefile("${path.root}/envfiles/alertmanager.env.tpl", {
    alertmanager_dns_name = local.alertmanager_dns_name
    alertmanager_web_port = var.alertmanager_service_container_web_port
    alertmanager_cluster_port = var.alertmanager_service_container_cluster_port
    alertmanager_cluster_peers = local.alertmanager_cluster_peers
    alertmanager_configuration_file_object_path = local.configuration_file_object_path
  })

  configuration = templatefile("${path.root}/configuration/alertmanager.yml.tpl", {})
}

resource "aws_s3_object" "env" {
  key = local.env_file_object_key
  bucket = var.secrets_bucket_name
  content = local.env

  server_side_encryption = "AES256"
}

resource "aws_s3_object" "configuration" {
  key = local.configuration_file_object_path
  bucket = var.secrets_bucket_name
  content = local.configuration

  server_side_encryption = "AES256"
}
