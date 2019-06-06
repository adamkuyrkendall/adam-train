resource "aws_subnet" "private_subnets" {
    provider = "aws.target-account"
    vpc_id = "${var.vpc_id}"
    count = "${length(var.private_subnets_map)}"

    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false

    availability_zone = "${element(split(",", var.private_subnets_map[count.index]),0)}"
    cidr_block = "${element(split(",", var.private_subnets_map[count.index]),1)}"

    tags = "${merge(var.default_tags,
            var.application_tags,
            map("Name", "sn-private-${var.aws_account_name}-${var.aws_region}-${var.vpc_id}")
    )}"
}