output "cloudwatch_metric_alarm_arns" {
  description = "List of ARN of the Cloudwatch metric alarms"
  value       = module.metric_alarms.this_cloudwatch_metric_alarm_arn
}

output "cloudwatch_metric_alarm_ids" {
  description = "List of ID of the Cloudwatch metric alarms"
  value       = module.metric_alarms.this_cloudwatch_metric_alarm_id
}