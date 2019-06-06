provider "aws" {
    alias = "target-account"
}

variable "name" {}

variable "principal_arns" {
  type        = "list"
}

variable "policy_arns" {
  type        = "list"
}