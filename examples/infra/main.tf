module "lambda" {
  source               = "../../"

  # Lambda configuration
  function_runtime = "python3.12"
  function_code = "../dist/app.zip"
  function_name            = "python-example_function"
  function_description = "Python example function"
  function_handler = "lambda_function.lambda_handler"

  function_role = "arn:aws:iam::211125374603:role/ExampleRole"
  environment_variables = {}
  # CloudWatch configuration
  log_retention_days = 1

  tags = {
    creator        = "danhenrique"
    git_repository = "https://github.com/DanHenrique/terraform-aws-iam-role"
  }
}
