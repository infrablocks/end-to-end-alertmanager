module "dns-delegation" {
  source  = "infrablocks/dns-delegation/aws"
  version = "0.4.0"

  parent_private_zone_id = data.terraform_remote_state.domain.outputs.private_zone_id

  delegated_domain_name = local.service_registry_domain_name

  # This is hardcoded since the aws_route53_zone datasource doesn't include
  # name servers for private hosted zones.
  #
  # For private hosted zones, the name servers are the fixed set included below
  # although we probably shouldn't rely on it.
  delegated_private_zone_name_servers = [
    "ns-0.awsdns-00.com",
    "ns-512.awsdns-00.net",
    "ns-1024.awsdns-00.org",
    "ns-1536.awsdns-00.co.uk"
  ]

  include_public_delegation_record = "no"
}
