module "global-state" {
  source = "../../../modules/global-state"
}

module "remote-state" {
  source = "../../../modules/remote-state"
  aws_account_name = "${var.aws_account_name}"
  default_tags = "${module.global-state.default_tags}"

  providers = {
    aws.target-account = "aws.primary-east"
  }
}

module "password-policy" {
  source = "../../../modules/security/password-policy"
  
  providers = {
    aws.target-account = "aws.primary-east"
  }
}

module "iam-groups" {
  source = "../../../modules/security/iam-groups"
  aws_account_name = "${var.aws_account_name}"
  
  providers = {
    aws.target-account = "aws.primary-east"
  }
}

module "administrator-cross-account-role" {
    source = "../../../modules/cross-account-role"
    name = "administrator"
    principal_arns = ["arn:aws:iam::966419090277:user/admin-cross-account-user"]
    policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]

    providers = {
        aws.target-account = "aws.primary-east"
    }
}

module "guard-duty-member" {
    source = "../../../modules/guard-duty-member"
    master_account_id = "${module.global-state.security_account_id}"

    providers = {
        aws.target-account = "aws.primary-east"
    }
}
