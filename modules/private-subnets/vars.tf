provider "aws" {
    alias = "target-account"
}

variable "aws_account_name" {}

variable "aws_region" {}

variable "default_tags" {
    type = "map"
    default = {}
}

variable "application_tags" {
    type = "map"
    default = {}
}

variable "vpc_id" {}

variable "private_subnets_map" {
    type = "map"
}