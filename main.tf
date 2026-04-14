data "aws_kms_key" "aws_managed" {
  key_id = "alias/aws/lambda"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.source_path
  output_path = "${path.module}/files/${var.name}.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.name
  description      = var.description
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role  
  memory_size      = var.memory
  timeout          = var.timeout
  architectures    = ["arm64"]  
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  layers                         = var.layers
  reserved_concurrent_executions = var.concurrent_executions  
  kms_key_arn                    = coalesce(var.kms_key_arn, data.aws_kms_key.aws_managed.arn)
  
  publish = var.publish_function

  environment {
    variables = var.environment_variables
  }
  tags = var.tags  
}

resource "aws_lambda_alias" "this" {
  count = var.publish_function ? 1 : 0

  name             = var.alias
  function_name    = aws_lambda_function.this.function_name
  function_version = aws_lambda_function.this.version
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.log_retention_days
}
