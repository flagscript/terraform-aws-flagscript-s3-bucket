# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "bucket_name_prefix" {
  description = "Prefix for the bucket name."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "allow_cloudfront_write" {
  default     = false
  description = "Whether or not to allow writes to cloudfront distributions."
  type        = bool
}

variable "bucket_name_suffix" {
  default     = ""
  description = "Optional bucket name suffix. Prefixed by '-'."
  type        = string
}

variable "cloudfront_distribution_arns" {
  default     = []
  description = "Arns of cloudfront distributions to allow access to the s3 bucket."
  type        = list(string)
}

variable "enable_bucket_key" {
  default     = true
  description = "Whether or not to use a bucket key."
  type        = bool
}

variable "enable_mfa_delete" {
  default     = false
  description = "Specifies whether MFA delete is enabled in the bucket versioning configuration."
  type        = bool
}

variable "kms_key_arn" {
  default     = ""
  description = "AWS KMS master key ID used for the SSE-KMS encryption."
  type        = string
}

variable "object_ownership" {
  default     = "BucketOwnerEnforced"
  description = "Object ownership control."
  type        = string

  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Variable object_ownership must be a valid value."
  }
}
