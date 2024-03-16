resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  handler          = var.function_handler
  runtime          = var.function_runtime
  role             = var.function_role
  filename         = data.archive_file.lambda_zip.output_path
  #source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

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

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_days
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.root}/${var.lambda_code_path}"
  output_path = "${path.root}/lambda_function_payload.zip"
}
