provider "aws" {
    alias = "target-account"
}

variable "aws_account_name" {}

variable "aws_region" {}

variable "vpc_id" {}

variable "default_tags" {
    type = "map"
    default = {}
}

variable "application_tags" {
    type = "map"
    default = {}
}

variable "igw_subnets_map" {
    type = "map"
}

variable "igw_destination_cidr_map" {
    type = "map"
}

