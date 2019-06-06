output "default_tags" {
    value = "${var.default_tags}"
}

output "aws_primary_region" {
    value = "${var.aws_primary_region}"
}

output "aws_secondary_region" {
    value = "${var.aws_secondary_region}"
}

###################################################
#  accounts
###################################################
output "primary_account_name" {
    value = "${var.primary_account_name}"
}

output "primary_account_id" {
    value = "${var.primary_account_id}"
}

output "primary_account_email" {
    value = "${var.primary_account_email}"
}

#############
#  auth
#############
output "auth_account_name" {
    value = "${var.auth_account_name}"
}

output "auth_account_id" {
    value = "${var.auth_account_id}"
}

output "auth_account_email" {
    value = "${var.auth_account_email}"
}

##############
#  network
##############
output "network_account_name" {
    value = "${var.network_account_name}"
}

output "network_account_id" {
    value = "${var.network_account_id}"
}

output "network_account_email" {
    value = "${var.network_account_email}"
}

################
#  logging
################
output "logging_account_name" {
    value = "${var.logging_account_name}"
}

output "logging_account_id" {
    value = "${var.logging_account_id}"
}

output "logging_account_email" {
    value = "${var.logging_account_email}"
}

########################
#  security
########################
output "security_account_name" {
    value = "${var.security_account_name}"
}

output "security_account_id" {
    value = "${var.security_account_id}"
}

output "security_account_email" {
    value = "${var.security_account_email}"
}