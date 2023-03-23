data "aws_iam_policy_document" "test" {
  
 policy  = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1656667324036",
      "Action": "events:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_event_bus_policy" "test" {
  policy         = data.aws_iam_policy_document.test.json
  event_bus_name = aws_cloudwatch_event_bus.test.name
}
