# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "bucket_name" {
  description = "Name of the bucket to which to apply the policy."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "require_sse_kms" {
  default     = false
  description = "Whether or not to use the require sse kms policy the standard bucket policy."
  type        = bool
}
