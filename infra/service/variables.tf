variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "domain_name" {}

variable "instance" {
  type = number
}
variable "cluster_size" {
  type = number
}

variable "service_name" {}
variable "service_registry_namespace" {}
variable "service_desired_count" {}

variable "secrets_bucket_name" {}

variable "alertmanager_image" {}
variable "alertmanager_service_container_web_port" {}
variable "alertmanager_service_host_web_port" {}
variable "alertmanager_service_container_cluster_port" {}
variable "alertmanager_service_host_cluster_port" {}
variable "alertmanager_storage_location" {}
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

variable "load_balancer_state_bucket_name" {}
variable "load_balancer_state_key" {}
variable "load_balancer_state_bucket_region" {}
variable "load_balancer_state_bucket_is_encrypted" {}

variable "service_registry_state_bucket_name" {}
variable "service_registry_state_key" {}
variable "service_registry_state_bucket_region" {}
variable "service_registry_state_bucket_is_encrypted" {}

variable "cluster_state_bucket_name" {}
variable "cluster_state_key" {}
variable "cluster_state_bucket_region" {}
variable "cluster_state_bucket_is_encrypted" {}
