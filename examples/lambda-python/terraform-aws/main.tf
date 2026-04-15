module "basic_lambda" {
  source = "../../modules/lambda"

  # mandatory
  name        = "basic-lambda-example"                                        # TODO: replace with your lambda name
  description = "Basic Lambda function example using all available variables" # TODO: replace with your lambda description
  handler     = "handler.lambda_handler"                                      # TODO: replace with your handler (file.function)
  runtime     = "python3.13"                                                  # TODO: replace with your runtime
  role        = "arn:aws:iam::000000000000:role/your-lambda-role"             # TODO: replace with your IAM role ARN
  source_path = "${path.module}/../app"                                       # TODO: replace with the path to your source code

  # publishing & alias (optional)
  # publish_function = true   # publish a new version on each deploy
  # alias            = "live" # required when publish_function = true

  # compute (optional)
  # memory  = 128  # MB — default: 128
  # timeout = 5    # seconds — default: 5

  # concurrency (optional)
  # concurrent_executions = -1  # -1 = unreserved — default: -1

  # layers (optional)
  # layers = []  # list of Lambda Layer Version ARNs — default: []

  # encryption (optional)
  # kms_key_arn = null  # ARN of KMS key for env var encryption — default: null

  # environment variables (optional)
  # environment_variables = {
  #   KEY = "value" # TODO: replace with your environment variables
  # }

  # cloudwatch logs (optional)
  # log_retention_days = 1  # days — default: 1

  # tags
  tags = {
    Repository = "owner/repository" # TODO: replace with your repository
    environment    = "dev"              # TODO: replace with your environment
  }
}
