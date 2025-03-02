variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "local_dist_path" {
  description = "Local path to the built app files (e.g., dist/)"
  type        = string
}