output "bucket_arn" {
  description = "ARN of the bucket."
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_domain_name" {
  description = "Bucket domain name."
  value       = aws_s3_bucket.bucket.bucket_domain_name
}

output "bucket_name" {
  description = "Name of the bucket."
  value       = aws_s3_bucket.bucket.id
}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name."
  value       = aws_s3_bucket.bucket.bucket_regional_domain_name
}

output "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID for this bucket's region."
  value       = aws_s3_bucket.bucket.hosted_zone_id
}
