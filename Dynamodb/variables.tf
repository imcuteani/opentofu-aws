# Variables declaration 

variable "region" {
  type        = string
  description = "The region of the deployment for AWS resources"
}

variable "access_key" {
  type        = string
  description = "The Access Key for the AWS credentials"
}

variable "secret_key" {
  type        = string
  description = "The Secret Key for the AWS credentials"
}

variable "table_class" {
  type        = string
  description = "The Dynamodb table class"
}

variable "stream_enabled" {
  type        = bool
  description = "The Dynamodb stream enablement status"
}

variable "server_side_encryption" {
  type        = bool
  description = "The server side encryption status for Dynamodb"
}

variable "kms_key_arn" {
  type        = string
  description = "The KMS key arn"
}
