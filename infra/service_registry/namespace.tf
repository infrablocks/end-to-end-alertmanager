locals {
  service_registry_domain_name = "${var.component}-${var.deployment_identifier}-sd.${var.domain_name}"
}

resource "aws_service_discovery_private_dns_namespace" "service_registry" {
  name = local.service_registry_domain_name
  description = "sd-private-dns-ns-${var.component}-${var.deployment_identifier}"
  vpc = data.aws_vpc.vpc.id
}
