provider "aws" {
    alias = "target-account"
}

variable "aws_account_name" {}

variable "default_tags" {
    type = "map"
    default = {}
}

variable "application_tags" {
    type = "map"
    default = {}
}