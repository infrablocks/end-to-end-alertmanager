locals {
  env_file_object_key = "alertmanager/service/environments/default.env"
  configuration_file_object_path = "alertmanager/service/configuration/alertmanager.yml"
}

data "template_file" "alertmanager_dns_name" {
  template = "$${component}-$${deployment_identifier}.$${domain}"

  vars = {
    component = var.component
    deployment_identifier = var.deployment_identifier
    domain = data.terraform_remote_state.domain.outputs.domain_name
  }
}

data "template_file" "env_file_object_path" {
  template = "s3://$${secrets_bucket}/$${environment_object_key}"

  vars = {
    secrets_bucket = var.secrets_bucket_name
    environment_object_key = local.env_file_object_key
  }
}

data "template_file" "configuration_file_object_path" {
  template = "s3://$${secrets_bucket}/$${configuration_file_object_path}"

  vars = {
    secrets_bucket = var.secrets_bucket_name
    configuration_file_object_path = local.configuration_file_object_path
  }
}

data "template_file" "env" {
  template = file("${path.root}/envfiles/alertmanager.env.tpl")

  vars = {
    alertmanager_dns_name = data.template_file.alertmanager_dns_name.rendered
    alertmanager_configuration_file_object_path = data.template_file.configuration_file_object_path.rendered
  }
}

data "template_file" "configuration" {
  template = file("${path.root}/configuration/alertmanager.yml.tpl")

  vars = {

  }
}

resource "aws_s3_bucket_object" "env" {
  key = local.env_file_object_key
  bucket = var.secrets_bucket_name
  content = data.template_file.env.rendered

  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "configuration" {
  key = local.configuration_file_object_path
  bucket = var.secrets_bucket_name
  content = data.template_file.configuration.rendered

  server_side_encryption = "AES256"
}
