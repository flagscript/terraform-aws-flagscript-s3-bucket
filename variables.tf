# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "bucket_name_prefix" {
  description = "Prefix for the bucket name."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "bucket_name_suffix" {
  default     = ""
  description = "Optional bucket name suffix. Prefixed by '-'."
  type        = string
}

variable "enable_bucket_key" {
  default     = true
  description = "Whether or not to use a bucket key."
  type        = bool
}

variable "is_cloudfront_bucket" {
  default     = false
  description = "Whether or not this bucket is a cloudfront origin."
  type        = bool
}

variable "require_sse_kms" {
  default     = false
  description = "Whether or not to use the require sse kms policy the standard bucket policy."
  type        = bool
}

variable "use_aws_owned_kms" {
  default     = false
  description = "Whether or not to use an aws owned kms key."
  type        = bool
}
