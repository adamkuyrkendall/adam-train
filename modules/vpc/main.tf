resource "aws_vpc" "main" {
    provider = "aws.target-account"
    cidr_block = "${var.cidr_block}"
    enable_dns_support = true
    enable_dns_hostnames = true
    enable_classiclink = false
    enable_classiclink_dns_support = false
    assign_generated_ipv6_cidr_block = false

    tags = "${merge(var.default_tags,
                    var.application_tags,
                    map("Name", "vpc-${var.aws_account_name}-${var.aws_region}")
    )}"
}

resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
    provider = "aws.target-account"
    name = "/aws/vpc/${aws_vpc.main.id}/flow-logs"
    retention_in_days = 30

    tags = "${merge(var.default_tags,
                    var.application_tags,
                    map("Name",      "vpc-flow-logs-${var.aws_account_name}-${var.aws_region}-${aws_vpc.main.id}",
                        "vpc-id",    "${aws_vpc.main.id}"
                    )
    )}"
}

resource "aws_iam_role" "vpc_flow_log_role" {
    provider = "aws.target-account"
    name = "iam-role-vpc-flow-logs-${aws_vpc.main.id}"

    tags = "${merge(var.default_tags,
            var.application_tags,
            map("Name",      "iam-role-vpc-flow-logs-${aws_vpc.main.id}",
                "vpc-id",    "${aws_vpc.main.id}"
            )
    )}"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "vpc-flow-logs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_flow_log_role_policy" {
    provider = "aws.target-account"
    name = "iam-role-vpc-flow-logs-${aws_vpc.main.id}"
    role = "${aws_iam_role.vpc_flow_log_role.id}"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_flow_log" "vpc_flow_log" {
    provider = "aws.target-account"
    vpc_id = "${aws_vpc.main.id}"
    iam_role_arn = "${aws_iam_role.vpc_flow_log_role.arn}"
    log_destination = "${aws_cloudwatch_log_group.vpc_flow_log_group.arn}"
    traffic_type = "ALL"
}
