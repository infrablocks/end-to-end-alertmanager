data "aws_acm_certificate" "wildcard" {
  domain = "*.${var.domain_name}"
}

module "load_balancer" {
  source = "infrablocks/application-load-balancer/aws"
  version = "1.2.0-rc.1"

  component = var.component
  deployment_identifier = var.deployment_identifier

  region = var.region
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  target_group_type = "ip"
  target_group_port = var.alertmanager_service_host_web_port

  listener_certificate_arn = data.aws_acm_certificate.wildcard.arn

  domain_name = data.terraform_remote_state.domain.outputs.domain_name
  public_zone_id = data.terraform_remote_state.domain.outputs.public_zone_id
  private_zone_id = data.terraform_remote_state.domain.outputs.private_zone_id

  expose_to_public_internet = "yes"
  include_public_dns_record = "yes"
}
