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

variable "lambda_statementId" {
  type        = string
  description = "The Lambda Statement Id"
}

variable "lambda_function" {
  type        = string
  description = "The lambda function"
}

variable "lambda_principal" {
  type        = string
  description = "The lambda principal"
}

variable "aws_sns_topic" {
  type        = string
  description = "the aws sns topic"
}

variable "aws_signer_signing_profile" {
  type        = string
  description = "The aws signer signing profile"
}

variable "sqs_name" {
  type        = string
  description = "The SQS name"
}

variable "protocol" {
  type        = string
  description = "The Lambda protocol"
}
/*
variable "file_name" {
  type        = string
  description = "The Lambda file name"
}
*/
variable "s3_bucket" {
  type        = string
  description = "The S3 bucket name"
}

variable "s3_key" {
  type        = string
  description = "The s3 key for the bucket"
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "The reserved concurrent execution limit for lambda"
}

variable "function_name" {
  type        = string
  description = "The Lambda Function Name"
}

variable "lambda_handler" {
  type        = string
  description = "The lambda handler"
}

variable "lambda_runtime" {
  type        = string
  description = "The lambda runtime"
}

variable "lambda_publish" {
  type        = bool
  description = "The lambda publish"
}

variable "lambda_architectures" {
  type        = list(string)
  description = "The lambda architectures"
}

variable "kms_key_arn" {
  type        = string
  description = "The kms key arm required for lambda function encryption"
}
/*
variable "subnet_ids" {
  type        = list(string)
  description = "The subnet ids for lambda function"
}

variable "security_group_ids" {
  type        = list(string)
  description = "The security group ids for lambda function"
}
*/
variable "iam_role_for_sns" {
  type        = string
  description = "The iam role for sns"
}

variable "tag_resource_name" {
  type        = string
  description = "The resource name"
}

variable "tag_resource_type" {
  type        = string
  description = "the resource type"
}

variable "tag_region" {
  type        = string
  description = "The resource region"
}

variable "tag_cost_center" {
  type        = string
  description = "The cost center"
}

variable "lambda_cloudwatch_action" {
  type        = string
  description = "The lambda cloudwatch action"

}

variable "lambda_cloudwatch_principal" {
  type        = string
  description = "the lambda cloudwatch principal"
}

variable "cloudwatch_log_group" {
  type        = string
  description = "The cloudwatch log group"
}

variable "cloudwatch_logging_name" {
  type        = string
  description = "The cloudwatch logging name"
}