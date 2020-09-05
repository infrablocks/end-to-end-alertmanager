variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "domain_name" {}

variable "service_desired_count" {}

variable "secrets_bucket_name" {}

variable "prometheus_image" {}
variable "prometheus_service_container_port" {}
variable "prometheus_service_host_port" {}
variable "prometheus_service_lb_port" {}
variable "prometheus_storage_location" {}
variable "prometheus_allow_cidrs" {
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

variable "cluster_state_bucket_name" {}
variable "cluster_state_key" {}
variable "cluster_state_bucket_region" {}
variable "cluster_state_bucket_is_encrypted" {}
