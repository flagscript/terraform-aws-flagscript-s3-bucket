# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
variable "bucket_name" {
  description = "Name of the bucket to which to apply the policy."
  type        = string
}

variable "distribution_arn" {
  description = "Arn of the cloudfront distribution."
  type        = string
}

# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
variable "allow_write" {
  default     = false
  description = "Whether or not to allow writes to the cloudfront distribution."
  type        = bool
}
