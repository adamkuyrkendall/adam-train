module "guard-duty-master" {
    source = "../../../modules/guard-duty-master"
    member_account_ids = ["${module.global-state.primary_account_id}", 
    "${module.global-state.auth_account_id}",
    "${module.global-state.network_account_id}",
    "${module.global-state.logging_account_id}"
    ]

    member_account_emails = ["${module.global-state.primary_account_email}",
        "${module.global-state.auth_account_email}",
        "${module.global-state.network_account_email}",
        "${module.global-state.logging_account_email}"
    ]

    providers = {
        aws.target-account = "aws.security-east"
    }
}
