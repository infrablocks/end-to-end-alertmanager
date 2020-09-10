data "terraform_remote_state" "load_balancer" {
  backend = "s3"

  config = {
    bucket = var.load_balancer_state_bucket_name
    key = var.load_balancer_state_key
    region = var.load_balancer_state_bucket_region
    encrypt = var.load_balancer_state_bucket_is_encrypted
  }
}