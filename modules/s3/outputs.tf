output "bucket_id" {
  value = aws_s3_bucket.vite_react_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.vite_react_bucket.arn
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "uploaded_files" {
  value = keys(aws_s3_object.app_files)
}