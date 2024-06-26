# Lambda variables
variable "function_architectures" {
  description = "Supported architectures for the Lambda function"
  type        = list(string)
  default     = ["x86_64"]
  validation {
    condition     = contains(["x86_64", "arm64"], var.function_runtime)
    error_message = "The function architecture must be one of the specified values: x86_64, arm64."
  }
}

variable "function_runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string

}

variable "function_code" {
  description = "Path to the Lambda function code"
  type        = string
}

variable "function_package_type" {
  description = "The package type for the Lambda function"
  type        = string
  default     = "Zip"
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "function_description" {
  description = "Lambda function description"
  type        = string
}

variable "function_handler" {
  description = "The entry point for the Lambda function"
  type        = string
}

variable "function_layers" {
  description = "The list of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda function"
  type        = list(string)
  default     = []

}

variable "function_memory" {
  description = "The amount of memory in MB allocated to the Lambda function"
  type        = number
}

variable "function_timeout" {
  description = "The amount of time in seconds that Lambda allows a function to run before stopping it"
  type        = number
  default     = 10
}

variable "function_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda function"
  type        = number
  default     = -1
}

variable "function_role" {
  description = "ARN da função IAM associada à função Lambda"
  type        = string
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt environment variables"
  type        = string
  default     = null
}

variable "publish_function" {
  description = "Whether to publish the Lambda function"
  type        = bool
  default     = false
}

variable "function_alias" {
  description = "The alias name for the function."
  type        = string
  default     = null

  validation {
    condition     = var.publish_function == false || (var.publish_function == true && length(var.function_alias) > 0)
    error_message = "The function_alias must be provided when publish_function is true."
  }
}

variable "environment_variables" {
  description = "Environment variables to set for the Lambda function"
  type        = map(string)
  default     = {}
}

# CloudWatch configuration
variable "log_retention_days" {
  description = "The number of days to retain log events for the Lambda function"
  type        = number
  default     = 1
}

# Both
variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
  validation {
    condition = contains(keys(var.tags), "git_repository")
    error_message = "The 'git_repository' tag is mandatory."
  }
}