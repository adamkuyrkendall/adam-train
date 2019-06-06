resource "aws_guardduty_detector" "master" {
  provider = "aws.target-account"
  enable = true
  finding_publishing_frequency = "FIFTEEN_MINUTES"
}

output "guardduty_detector_master_id" {
  value = "${aws_guardduty_detector.master.id}"
}

resource "aws_guardduty_member" "members" {
  provider = "aws.target-account"
  count              = "${length(var.member_account_ids)}"
  detector_id        = "${aws_guardduty_detector.master.id}"
  account_id         = "${element(var.member_account_ids, count.index)}"
  email              = "${element(var.member_account_emails, count.index)}"
  invite             = true
  invitation_message = "GuardDuty Invite - Please accept this invitation if you are expecting it."
}