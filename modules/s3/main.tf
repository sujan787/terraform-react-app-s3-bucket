resource "aws_s3_bucket" "vite_react_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "Vite React App Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.vite_react_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.vite_react_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.vite_react_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.vite_react_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

# Upload files from terraform/react-app/dist/
resource "aws_s3_object" "app_files" {
  for_each = fileset("${path.module}/${var.local_dist_path}", "**/*") # path.module is terraform/modules/s3/

  bucket       = aws_s3_bucket.vite_react_bucket.id
  key          = each.value
  source       = "${path.module}/${var.local_dist_path}/${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  etag         = filemd5("${path.module}/${var.local_dist_path}/${each.value}")

  depends_on = [aws_s3_bucket.vite_react_bucket]
}

locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
  }
}