output "policy_json" {
  description = "The json policy document."
  value       = data.aws_iam_policy_document.bucket_policy_document.id
}
