module "vpc-primary" {
    source = "../../../modules/vpc"
    aws_account_name = "${var.aws_account_name}"
    aws_region = "${module.global-state.aws_primary_region}"
    cidr_block = "${var.vpc_primary_cidr_block}"
    default_tags = "${module.global-state.default_tags}"
    
    providers = {
        aws.target-account = "aws.logging-east"
    }
}

module "internet-gateway-primary" {
    source = "../../../modules/internet-gateway"
    aws_account_name = "${var.aws_account_name}"
    aws_region = "${module.global-state.aws_primary_region}"
    vpc_id = "${module.vpc-primary.vpc_id}"
    igw_subnets_map = "${var.igw_subnets_map_primary}"
    igw_destination_cidr_map = "${var.igw_destination_cidr_map}"
    default_tags = "${module.global-state.default_tags}"

    providers = {
        aws.target-account = "aws.logging-east"
    }
}

module "nat-gateway-primary" {
    source = "../../../modules/nat-gateway"
    aws_account_name = "${var.aws_account_name}"
    aws_region = "${module.global-state.aws_primary_region}"
    vpc_id = "${module.vpc-primary.vpc_id}"

    igw_subnets = "${module.internet-gateway-primary.igw_subnet_ids}"
    ngw_subnets_map = "${var.ngw_subnets_map_primary}"
    ngw_destination_cidr_map = "${var.ngw_destination_cidr_map}"
    ngw_egress_rules = "${var.ngw_egress_rules}"
    default_tags = "${module.global-state.default_tags}"

    providers = {
        aws.target-account = "aws.logging-east"
    }
}

module "private-subnets" {
    source = "../../../modules/private-subnets"
    aws_account_name = "${var.aws_account_name}"
    aws_region = "${module.global-state.aws_primary_region}"
    vpc_id = "${module.vpc-primary.vpc_id}"
    private_subnets_map = "${var.private_subnets_map_primary}"

    providers = {
        aws.target-account = "aws.logging-east"
    }
}