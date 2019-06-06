terraform {
  required_version = ">= 0.12"
    backend "s3" {
        shared_credentials_file = "~/.aws/credentials"
        profile = "auth"
        bucket = "adam-train-auth-terraform-remote-state-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
  }
}

provider "aws" {
  version                 = "2.13"
  alias                   = "auth-east"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "auth"
  region = "us-east-1"
}

provider "aws" {
  version                 = "2.13"
  alias                   = "auth-west"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "auth"
  region = "us-west-2"
}


