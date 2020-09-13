variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "private_network_cidr" {}

variable "domain_name" {}

variable "alertmanager_service_container_web_port" {}
variable "alertmanager_service_host_web_port" {}
variable "alertmanager_allow_cidrs" {
  type = list(string)
}


variable "domain_state_bucket_name" {}
variable "domain_state_key" {}
variable "domain_state_bucket_region" {}
variable "domain_state_bucket_is_encrypted" {}

variable "network_state_bucket_name" {}
variable "network_state_key" {}
variable "network_state_bucket_region" {}
variable "network_state_bucket_is_encrypted" {}
