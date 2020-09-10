data "terraform_remote_state" "service_registry" {
  backend = "s3"

  config = {
    bucket = var.service_registry_state_bucket_name
    key = var.service_registry_state_key
    region = var.service_registry_state_bucket_region
    encrypt = var.service_registry_state_bucket_is_encrypted
  }
}