module "iam_role_with_policies" {
  source               = "../../"

  # Lambda configuration
  function_name            = "python-example_function"
  function_handler = "lambda_function.lambda_handler"
  function_runtime = "python3.12"
  function_role = "arn:aws:iam::211125374603:role/ExampleRole"
  lambda_code_path = "../app"
  environment_variables = {}
  # CloudWatch configuration
  log_retention_days = 1

  tags = {
    creator        = "danhenrique"
    git_repository = "https://github.com/DanHenrique/terraform-aws-iam-role"
  }
}
