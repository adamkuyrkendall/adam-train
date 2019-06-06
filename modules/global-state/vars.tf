

variable "default_tags" {
    type = "map"

    default = {
        application-id = "adam-train"
        source-control = "https://github.com/adamkuyrkendall/adam-train.git"
    }
}

variable "aws_primary_region" {
    default = "us-east-1"
}

variable "aws_secondary_region" {
    default = "us-west-2"
}

variable "primary_account_name" {
    default = "adam-train"
}

variable "primary_account_id" {}

variable "primary_account_email" {}

variable "auth_account_name" {}

variable "auth_account_id" {}

variable "auth_account_email" {}

variable "network_account_name" {}

variable "network_account_id" {}

variable "network_account_email" {}

variable "logging_account_name" {}

variable "logging_account_id" {}

variable "logging_account_email" {}

variable "security_account_name" {}

variable "security_account_id" {}

variable "security_account_email" {}







