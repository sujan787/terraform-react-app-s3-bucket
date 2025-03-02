module "s3" {
  source         = "./modules/s3"
  bucket_name    = var.bucket_name
  aws_region     = var.aws_region
  local_dist_path = var.local_dist_path
}