terraform {
  required_version = ">= 0.12"
    backend "s3" {
        shared_credentials_file = "~/.aws/credentials"
        profile = "network"
        bucket = "network-terraform-remote-state-bucket"
        key    = "terraform.tfstate"
        region = "us-east-1"
  }
}

provider "aws" {
  version                 = "2.13"
  alias                   = "network-east"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "network"
  region = "us-east-1"
}

provider "aws" {
  version                 = "2.13"
  alias                   = "network-west"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "network"
  region = "us-west-2"
}
