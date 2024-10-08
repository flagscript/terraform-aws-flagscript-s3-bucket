# names required TF version
terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.60"
      configuration_aliases = [aws.source, aws.destination]
    }
  }
}
