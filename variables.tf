# Lambda
variable "function_name" {
  description = "Nome da função Lambda"
  type        = string
}

variable "function_handler" {
  description = "Handler da função Lambda"
  type        = string
}

variable "function_runtime" {
  description = "Runtime da função Lambda (ex: nodejs14.x)"
  type        = string
}

variable "function_role" {
  description = "ARN da função IAM associada à função Lambda"
  type        = string
}

variable "lambda_code_path" {
  description = "Caminho para o diretório do código do Lambda"
  type        = string
}

variable "environment_variables" {
  description = "Variáveis de ambiente para a função Lambda"
  type        = map(string)
  default     = {}
}

/* variable "subnet_ids" {
  description = "IDs das sub-redes para configurar a função Lambda dentro de uma VPC"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "IDs dos grupos de segurança para configurar a função Lambda dentro de uma VPC"
  type        = list(string)
  default     = []
} */

# CloudWatch
variable "log_retention_days" {
  description = "Número de dias para retenção de logs no CloudWatch"
  type        = number
  default     = 7
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