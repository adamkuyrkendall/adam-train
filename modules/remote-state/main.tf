resource "aws_s3_bucket" "terraform_remote_state_bucket" {
  provider = "aws.target-account"
  bucket = "${var.aws_account_name}-terraform-remote-state-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name",      "${var.aws_account_name}-terraform-remote-state-bucket"
        )
  )}"
}


resource "aws_s3_bucket_public_access_block" "terraform_remote_state_bucket_public_access_block" {
  provider = "aws.target-account"
  bucket = "${aws_s3_bucket.terraform_remote_state_bucket.id}"

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  provider = "aws.target-account"

  name = "${var.aws_account_name}-terraform-remote-lock-table"
  read_capacity = 5
  write_capacity = 5
  hash_key = "LockID"
  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = "${merge(var.default_tags,
      var.application_tags,
      map("Name",      "${var.aws_account_name}-terraform-remote-lock-table"
      )
  )}"
}