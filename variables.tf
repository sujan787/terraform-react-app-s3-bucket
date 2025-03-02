variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "local_dist_path" {
  description = "Local path to the built app files relative to modules/s3/"
  type        = string
  default     = "../../react-app/dist" # Relative to terraform/modules/s3/, go up one level then into react-app/dist
}