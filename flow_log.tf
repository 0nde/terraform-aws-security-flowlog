# flowlog

resource "aws_cloudwatch_log_group" "flowlogs" {
  name = "flowlogs-${var.aws_vpc_id}"
}

resource "aws_flow_log" "default" {
  log_group_name = "${aws_cloudwatch_log_group.flowlogs.name}"
  iam_role_arn   = "${aws_iam_role.flowlogrole.arn}"
  vpc_id         = "${var.aws_vpc_id}"
  traffic_type   = "ALL"
}

resource "aws_iam_role" "flowlogrole" {
  name               = "flowlogrole"
  assume_role_policy = "${data.aws_iam_policy_document.flowlogrole.json}"
}

resource "aws_iam_role_policy" "flowlogpolicy" {
  name   = "flowlogpolicy"
  role   = "${aws_iam_role.flowlogrole.id}"
  policy = "${data.aws_iam_policy_document.flowlogpolicy.json}"
}