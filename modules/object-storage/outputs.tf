output "id" {
  value = aws_s3_bucket.tfstate.arn
}

output "arn" {
  value = aws_s3_bucket.tfstate.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.tfstate.bucket_domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.tfstate.bucket
}