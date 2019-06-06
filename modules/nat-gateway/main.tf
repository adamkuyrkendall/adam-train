resource "aws_eip" "nat_eip" {
    provider = "aws.target-account"
    count = "${length(var.ngw_subnets_map)}"
    vpc = true

    tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name", "eip-${var.aws_account_name}-${element(split(",", var.ngw_subnets_map[count.index]),0)}")
    )}"
}

resource "aws_subnet" "ngw_subnets" {
    provider = "aws.target-account"
    vpc_id = "${var.vpc_id}"
    count = "${length(var.ngw_subnets_map)}"
    map_public_ip_on_launch = false
    assign_ipv6_address_on_creation = false
    availability_zone = "${element(split(",",var.ngw_subnets_map[count.index]),0)}"
    cidr_block = "${element(split(",",var.ngw_subnets_map[count.index]),1)}"
    
    tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name", "sn-ngw-${var.aws_account_name}-${element(split(",",var.ngw_subnets_map[count.index]),0)}")
    )}"
}

resource "aws_nat_gateway" "ngw" {
    provider = "aws.target-account"
    count = "${length(var.igw_subnets)}"
    allocation_id = "${element(aws_eip.nat_eip.*.id, count.index)}"
    subnet_id = "${element(var.igw_subnets, count.index)}"
    
    tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name", "ngw-${var.aws_account_name}-${element(split(",",var.ngw_subnets_map[count.index]),0)}")
    )}"
}

resource "aws_route_table" "ngw_route_table" {
    provider = "aws.target-account"
    count = "${length(var.ngw_subnets_map)}"
    vpc_id = "${var.vpc_id}"
    
    tags = "${merge(var.default_tags,
        var.application_tags,
        map("Name", "rtb-ngw-${var.aws_account_name}-${element(split(",",var.ngw_subnets_map[count.index]),0)}")
    )}"
}

resource "aws_route" "ngw_route_0" {
    provider = "aws.target-account"
    count = "${length(var.ngw_destination_cidr_map)}"
    route_table_id = "${aws_route_table.ngw_route_table.0.id}"
    destination_cidr_block = "${element(split(",", var.ngw_destination_cidr_map[count.index]),0)}"
    nat_gateway_id = "${aws_nat_gateway.ngw.0.id}"
}

resource "aws_route" "ngw_route_1" {
    provider = "aws.target-account"
    count = "${length(var.ngw_destination_cidr_map)}"
    route_table_id = "${aws_route_table.ngw_route_table.1.id}"
    destination_cidr_block = "${element(split(",", var.ngw_destination_cidr_map[count.index]),0)}"
    nat_gateway_id = "${aws_nat_gateway.ngw.1.id}"
}

resource "aws_route" "ngw_route_2" {
    provider = "aws.target-account"
    count = "${length(var.ngw_destination_cidr_map)}"
    route_table_id = "${aws_route_table.ngw_route_table.2.id}"
    destination_cidr_block = "${element(split(",", var.ngw_destination_cidr_map[count.index]),0)}"
    nat_gateway_id = "${aws_nat_gateway.ngw.2.id}"
}

resource "aws_route_table_association" "ngw_route_table_association" {
    provider = "aws.target-account"
    count = "${length(var.igw_subnets)}"
    subnet_id = "${element(aws_subnet.ngw_subnets.*.id, count.index)}"
    route_table_id = "${element(aws_route_table.ngw_route_table.*.id, count.index)}"
}

resource "aws_network_acl" "ngw_acl" {
    provider = "aws.target-account"
    # count = "${length(var.ngw_egress_rules)}"
    vpc_id = "${var.vpc_id}"
    subnet_ids = "${split(",", join(",", aws_subnet.ngw_subnets.*.id))}"

    #TODO: add tags
}

resource "aws_network_acl_rule" "ngw_network_acl_rule" {
    provider = "aws.target-account"
    count = "${length(var.ngw_egress_rules)}"
    network_acl_id = "${aws_network_acl.ngw_acl.id}"
    egress = true
    protocol   = "${element(split(",", var.ngw_egress_rules[count.index]),0)}"
    rule_number    = "${element(split(",", var.ngw_egress_rules[count.index]),1)}"
    rule_action     = "${element(split(",", var.ngw_egress_rules[count.index]),2)}"
    cidr_block = "${element(split(",", var.ngw_egress_rules[count.index]),3)}"
    from_port  = "${element(split(",", var.ngw_egress_rules[count.index]),4)}"
    to_port    = "${element(split(",", var.ngw_egress_rules[count.index]),5)}"
}





