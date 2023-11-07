# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "application_id" {
  description = "Application Id"
  type        = string
}

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

variable "require_sse_kms" {
  default     = false
  description = "Whether or not to use the require sse kms policy the standard bucket policy."
  type        = bool
}

variable "use_standard_bucket_policy" {
  default     = true
  description = "Whether or not to use the standard bucket policy."
  type        = bool
}
