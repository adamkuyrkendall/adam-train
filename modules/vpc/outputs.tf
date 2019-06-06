##############################################
#  vpc outputs
##############################################

output "vpc_id" {
    value = "${aws_vpc.main.id}"
}

output "vpc_arn" {
    value = "${aws_vpc.main.arn}"
}

output "vpc_cidr_block" {
    value = "${aws_vpc.main.cidr_block}"
}

output "vpc_instance_tenancy" {
    value = "${aws_vpc.main.instance_tenancy}"
}

output "vpc_enable_dns_support" {
    value = "${aws_vpc.main.enable_dns_support}"
}

output "vpc_enable_dns_hostnames" {
    value = "${aws_vpc.main.enable_dns_hostnames}"
}

output "vpc_enable_classiclink" {
    value = "${aws_vpc.main.enable_classiclink}"
}

#############################################################
#  cloudwatch log group
#############################################################

output "cwl_arn" {
    value = "${aws_cloudwatch_log_group.vpc_flow_log_group.arn}"
}

