######################################################
#  internet gateway outputs
######################################################

output "igw_id" {
    value = "${aws_internet_gateway.igw.id}"
}

output "igw_owner_id" {
    value = "${aws_internet_gateway.igw.owner_id}"
}

output "igw_subnet_ids" {
    value = "${split(",", join(",", aws_subnet.igw_subnets.*.id))}"
}