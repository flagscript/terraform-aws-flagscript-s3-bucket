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
