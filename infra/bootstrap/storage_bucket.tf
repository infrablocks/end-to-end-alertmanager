module "storage_bucket" {
  source = "infrablocks/encrypted-bucket/aws"
  version = "3.1.0"

  bucket_name = var.storage_bucket_name

  tags = {
    DeploymentIdentifier = var.deployment_identifier
  }
}
