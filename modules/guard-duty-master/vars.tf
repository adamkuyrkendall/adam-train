provider "aws" {
  alias = "target-account"
}

variable "member_account_ids" {
  type = "list"
}

variable "member_account_emails" {
  type = "list"
}
