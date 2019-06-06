resource "aws_iam_group" "administrators" {
  provider = "aws.target-account"
  name = "${var.aws_account_name}-administrators"
  path = "/users/"
}

resource "aws_iam_group_policy_attachment" "administrators-attach" {
  provider = "aws.target-account"
  group      = "${aws_iam_group.administrators.name}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group" "read_only" {
    provider = "aws.target-account"
    name = "${var.aws_account_name}-read-only"
    path = "/users/"
}

resource "aws_iam_group_policy_attachment" "read-only-attach" {
  provider = "aws.target-account"
  group      = "${aws_iam_group.read_only.name}"
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}