resource "aws_guardduty_detector" "member" {
  provider = "aws.target-account"
}

resource "aws_guardduty_invite_accepter" "member" {
  provider   = "aws.target-account"

  detector_id       = "${aws_guardduty_detector.member.id}"
  master_account_id = "${var.master_account_id}"
}