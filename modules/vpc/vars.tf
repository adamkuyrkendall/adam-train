provider "aws" {
    alias = "target-account"
}

variable "aws_account_name" {}

variable "aws_region" {}

variable "cidr_block" {}

variable "default_tags" {
    type = "map"
    default = {}
}

variable "application_tags" {
    type = "map"
    default = {}
}