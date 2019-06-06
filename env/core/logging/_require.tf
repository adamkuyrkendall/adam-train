terraform {
  required_version = ">= 0.12"
    backend "s3" {
        shared_credentials_file = "~/.aws/credentials"
        profile = "logging"
        bucket = "adam-train-logging-terraform-remote-state-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
  }
}

provider "aws" {
  version                 = "2.13"
  alias                   = "logging-east"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "logging"
  region = "us-east-1"
}

provider "aws" {
  version                 = "2.13"
  alias                   = "logging-west"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "logging"
  region = "us-west-2"
}
