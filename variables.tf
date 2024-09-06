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

variable "kms_key_arn" {
  default     = ""
  description = "AWS KMS master key ID used for the SSE-KMS encryption."
  type        = string
}

variable "enable_bucket_key" {
  default     = true
  description = "Whether or not to use a bucket key."
  type        = bool
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
