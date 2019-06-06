##############################################
#  Administrators
##############################################
resource "aws_iam_user" "admin_user" {
  provider = "aws.auth-east"
  name = "admin-cross-account-user"

  tags = "${module.global-state.default_tags}"
}

resource "aws_iam_access_key" "admin_user_key" {
  provider = "aws.auth-east"
  user = "${aws_iam_user.admin_user.name}"
}

resource "aws_iam_user_policy" "admin_user_policy" {
  provider = "aws.auth-east"
  name = "admin-cross-account-user-policy"
  user = "${aws_iam_user.admin_user.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

