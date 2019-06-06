###########################################################
#  primary
###########################################################
module "vpc-primary" {
    source = "../../../modules/vpc"
    aws_account_name = "adam-train-network"
    aws_region = "${module.global-state.aws_primary_region}"
    cidr_block = "10.0.0.0/21"
    default_tags = "${module.global-state.default_tags}"
    
    providers = {
        aws.target-account = "aws.network-east"
    }
}


###########################################
#  secondary
###########################################
module "vpc-secondary" {
    source = "../../../modules/vpc"
    aws_account_name = "adam-train-network"
    aws_region = "${module.global-state.aws_secondary_region}"
    cidr_block = "10.0.8.0/21"
    default_tags = "${module.global-state.default_tags}"
    
    providers = {
        aws.target-account = "aws.network-west"
    }
}