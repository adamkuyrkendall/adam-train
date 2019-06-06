#######################################################################
#  s3 state bucket
#######################################################################
output "terraform_remote_state_bucket_id" {
  value = "${aws_s3_bucket.terraform_remote_state_bucket.id}"
}

output "terraform_remote_state_bucket_arn" {
  value = "${aws_s3_bucket.terraform_remote_state_bucket.arn}"
}

output "terraform_remote_state_bucket_bucket_domain_name" {
  value = "${aws_s3_bucket.terraform_remote_state_bucket.bucket_domain_name}"
}

output "terraform_remote_state_bucket_bucket_regional_domain_name" {
  value = "${aws_s3_bucket.terraform_remote_state_bucket.bucket_regional_domain_name}"
}

output "terraform_remote_state_bucket_region" {
  value = "${aws_s3_bucket.terraform_remote_state_bucket.region}"
}

#######################################################################
#  dynamodb lock table
#######################################################################
output "terraform_lock_table_arn" {
  value = "${aws_dynamodb_table.terraform_lock_table.arn}"
}

output "terraform_lock_table_id" {
  value = "${aws_dynamodb_table.terraform_lock_table.id}"
}