variable "aws_account_name" {
    default = "adam-train-logging"
}

############################################################
#  primary region
############################################################
variable "vpc_primary_cidr_block" {
    default = "10.0.16.0/21"
}

variable "igw_subnets_map_primary" {
    type = "map"
     
    default = {
        "0" = "us-east-1a,10.0.16.0/26"
        "1" = "us-east-1b,10.0.16.64/27"
        "2" = "us-east-1c,10.0.16.128/27"
    }
}

variable "igw_destination_cidr_map" {
    type = "map"

    default = {
        "0" = "172.217.12.68/32"
    }
}

variable "ngw_subnets_map_primary" {
    type = "map"
        default = {
        "0" = "us-east-1a,10.0.17.0/26"
        "1" = "us-east-1b,10.0.17.64/27"
        "2" = "us-east-1c,10.0.17.128/27"
    }
}

variable "ngw_destination_cidr_map" {
    type = "map"

    default = {
        "0" = "216.58.193.132/32"
        "1" = "10.0.0.0/16"
    }
}

variable "ngw_egress_rules" {
    type = "map"
    default = {
        "0" = "tcp,100,allow,216.58.193.132/32,443,443"
        "1" = "tcp,200,allow,10.0.0.0/16,443,443"   
    }
}


variable "private_subnets_map_primary" {
    type = "map"
        default = {
        "0" = "us-east-1a,10.0.18.0/26"
        "1" = "us-east-1b,10.0.18.64/27"
        "2" = "us-east-1c,10.0.18.128/27"
    }
}











#############################################################
#  secondary region
#############################################################
variable "vpc_secondary_cidr_block" {
    default = "10.0.24.0/21"
}

