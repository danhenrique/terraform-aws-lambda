resource "aws_lambda_function" "default" {
  architectures    = var.function_architectures
  runtime          = var.function_runtime
  filename         = var.function_code
  source_code_hash = filebase64sha256(var.function_code)
  package_type = var.function_package_type

  function_name    = var.function_name
  description      = var.function_description
  handler          = var.function_handler
  layers = var.function_layers

  memory_size = var.function_memory
  timeout = var.function_timeout
  reserved_concurrent_executions = var.function_concurrent_executions

  role             = var.function_role
  kms_key_arn = var.kms_key_arn

  publish = var.publish_function

  environment {
    variables = var.environment_variables
  }

  tags = var.tags

  /* tracing_config {
    mode = "Active"
  } */

  vpc_config {
    subnet_ids         = data.aws_subnets.default.ids
    security_group_ids = data.aws_security_groups.default.ids
  }
}

resource "aws_lambda_alias" "default" {
  count = var.publish_function ? 1 : 0

  name             = var.function_alias
  function_name    = aws_lambda_function.default.function_name
  function_version = aws_lambda_function.default.version
}

resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${aws_lambda_function.default.function_name}"
  retention_in_days = var.log_retention_days
}
