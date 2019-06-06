data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  provider = "aws.target-account"

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = "${var.principal_arns}"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cross_account_assume_role" {
  provider = "aws.target-account"
  name               = "${var.name}-cross-account-role"
  assume_role_policy = "${data.aws_iam_policy_document.cross_account_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "cross_account_assume_role" {
  provider = "aws.target-account"
  count = "${length(var.policy_arns)}"

  role       = "${aws_iam_role.cross_account_assume_role.name}"
  policy_arn = "${element(var.policy_arns, count.index)}"
}