resource "aws_cloudwatch_event_target" "yada" {
  target_id = "Yada"
  rule      = aws_cloudwatch_event_rule.console.name
  arn       = aws_kinesis_stream.test_stream.arn

  run_command_targets {
    key    = "tag:Name"
    values = ["FooBar"]
  }

  run_command_targets {
    key    = "InstanceIds"
    values = ["i-0ffc5f26be425a278"]
  }
}

resource "aws_cloudwatch_event_rule" "console1" {
  name        = "capture-ec2-scaling-events"
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    
    "EC2 Instance Terminate Successful",
   
  ]
}
PATTERN
}

resource "aws_kinesis_stream" "test_stream" {
  name        = "terraform-kinesis-test"
  shard_count = 1
}