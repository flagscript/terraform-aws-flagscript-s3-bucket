# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "source_bucket_name" {
  description = "Name of the source bucket."
  type        = string
}

variable "destination_bucket_name" {
  description = "Name of the destination bucket."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "filter_prefix" {
  default     = ""
  description = "Optional prefix to filter replication."
  type        = string
}

variable "replicate_delete_markers" {
  default     = true
  description = "Whether delete markers are replicated."
  type        = bool
}
