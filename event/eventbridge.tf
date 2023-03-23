resource "aws_cloudwatch_event_bus" "event" {
  name = "chat-event"
}
data "aws_cloudwatch_event_source" "examplepartner" {
  name_prefix = "aws.partner/examplepartner.com"
}

resource "aws_cloudwatch_event_bus" "examplepartner" {
  name              = data.aws_cloudwatch_event_source.examplepartner.name
  event_source_name = data.aws_cloudwatch_event_source.examplepartner.name
}