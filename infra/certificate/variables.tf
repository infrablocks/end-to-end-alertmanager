variable "region" {}

variable "domain_name" {}

variable "domain_state_key" {}
variable "domain_state_bucket_name" {}
variable "domain_state_bucket_region" {}
variable "domain_state_bucket_is_encrypted" {
  default = true
  nullable = false
}
