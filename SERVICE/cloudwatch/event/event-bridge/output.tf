output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.cloudwatch_event_rule.*.arn
}

output "cloudwatch_event_rule_name" {
  value = aws_cloudwatch_event_rule.cloudwatch_event_rule.*.id
}