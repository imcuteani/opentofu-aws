resource "aws_lambda_permission" "with_sns" {
  depends_on    = [aws_sns_topic.default, aws_lambda_function.func, aws_iam_role.default]
  statement_id  = var.lambda_statementId
  action        = var.lambda_function
  function_name = aws_lambda_function.func.function_name
  principal     = var.lambda_principal
  source_arn    = aws_sns_topic.default.arn
}

resource "aws_sns_topic" "default" {
  name              = var.aws_sns_topic
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.default.arn
  protocol  = var.protocol
  endpoint  = aws_lambda_function.func.arn
}

resource "aws_signer_signing_profile" "this" {
  platform_id = "AWSLambda-SHA384-ECDSA"
  # invalid value for name (must be alphanumeric with max length of 64 characters)
  name = var.aws_signer_signing_profile

  signature_validity_period {
    value = 3
    type  = "MONTHS"
  }
}

resource "aws_lambda_code_signing_config" "this" {
  allowed_publishers {
    signing_profile_version_arns = [aws_signer_signing_profile.this.version_arn]
  }

  policies {
    untrusted_artifact_on_deployment = "Warn"
  }
}

resource "aws_sqs_queue" "dlq" {
  name                              = var.sqs_name
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}

resource "aws_lambda_function" "func" {
  depends_on = [aws_signer_signing_profile.this, aws_sns_topic.default, aws_iam_role.default]
  # filename      = var.file_name
  s3_bucket                      = var.s3_bucket
  s3_object_version              = null
  s3_key                         = var.s3_key
  function_name                  = var.function_name
  role                           = aws_iam_role.default.arn
  handler                        = var.lambda_handler
  runtime                        = var.lambda_runtime
  publish                        = var.lambda_publish
  architectures                  = var.lambda_architectures
  reserved_concurrent_executions = var.reserved_concurrent_executions
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
  code_signing_config_arn = aws_lambda_code_signing_config.this.arn
  dead_letter_config {
    target_arn = aws_sqs_queue.dlq.arn
  }
  kms_key_arn = var.kms_key_arn
  /*
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  */
  tags = {
    "resourcename" = var.tag_resource_name
    "resourcetype" = var.tag_resource_type
    "costcenter"   = var.tag_cost_center
    "region"       = var.tag_region
  }
  environment {
    variables = {
      env = "dev"
    }
  }
}

resource "aws_iam_role" "default" {
  name = var.iam_role_for_sns

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "lambda"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}
/*
resource "aws_lambda_permission" "logging" {
  action        = var.lambda_cloudwatch_action
  function_name = aws_lambda_function.logging.function_name
  principal     = var.lambda_cloudwatch_principal
  source_arn    = "${aws_cloudwatch_log_group.default.arn}:*"
}

resource "aws_cloudwatch_log_group" "default" {
  name = var.cloudwatch_log_group
}

resource "aws_cloudwatch_log_subscription_filter" "logging" {
  depends_on      = [aws_lambda_permission.logging]
  destination_arn = aws_lambda_function.logging.arn
  filter_pattern  = ""
  log_group_name  = aws_cloudwatch_log_group.default.name
  name            = var.cloudwatch_logging_name
}
*/