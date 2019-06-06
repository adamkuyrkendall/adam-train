terraform {
  required_version = ">= 0.12"
    backend "s3" {
        shared_credentials_file = "~/.aws/credentials"
        profile = "security"
        bucket = "adam-train-security-terraform-remote-state-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
  }
}

provider "aws" {
  version                 = "2.13"
  alias                   = "security-east"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "security"
  region = "us-east-1"
}

provider "aws" {
  version                 = "2.13"
  alias                   = "security-west"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "security"
  region = "us-west-2"
}


