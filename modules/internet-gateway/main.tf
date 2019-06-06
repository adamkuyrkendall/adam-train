resource "aws_internet_gateway" "igw" {
    provider = "aws.target-account"
    vpc_id = "${var.vpc_id}"

    tags = "${merge(var.default_tags,
                var.application_tags,
                map("Name", "igw-${var.aws_account_name}-${var.aws_region}-${var.vpc_id}")
    )}"
}

resource "aws_subnet" "igw_subnets" {
    provider = "aws.target-account"
    vpc_id = "${var.vpc_id}"
    count = "${length(var.igw_subnets_map)}"

    map_public_ip_on_launch = true
    assign_ipv6_address_on_creation = false

    availability_zone = "${element(split(",", var.igw_subnets_map[count.index]),0)}"
    cidr_block = "${element(split(",", var.igw_subnets_map[count.index]),1)}"

    tags = "${merge(var.default_tags,
            var.application_tags,
            map("Name", "sn-igw-${var.aws_account_name}-${var.aws_region}-${var.vpc_id}")
    )}"
}

resource "aws_route_table" "igw_route_table" {
    vpc_id = "${var.vpc_id}"
    provider = "aws.target-account"

    tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name", "rtb-igw-${var.aws_account_name}-${var.aws_region}-${var.vpc_id}")
    )}"
}

resource "aws_route" "igw_route" {
    provider = "aws.target-account"
    count = "${length(var.igw_destination_cidr_map)}"
    route_table_id = "${aws_route_table.igw_route_table.id}"
    destination_cidr_block = "${element(split(",", var.igw_destination_cidr_map[count.index]),0)}"
    gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "igw_route_table_association" {
    provider = "aws.target-account"
    count = "${length(var.igw_subnets_map)}"
    subnet_id = "${element(aws_subnet.igw_subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.igw_route_table.id}"
}
