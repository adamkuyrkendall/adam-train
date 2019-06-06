terraform {
  required_version = ">= 0.12"
    backend "s3" {
        shared_credentials_file = "~/.aws/credentials"
        profile = "primary"
        bucket = "primary-terraform-remote-state-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
  }
}

provider "aws" {
  version                 = "2.13"
  alias                   = "primary-east"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "primary"
  region = "us-east-1"
}

provider "aws" {
  version                 = "2.13"
  alias                   = "primary-west"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "primary"
  region = "us-west-2"
}


