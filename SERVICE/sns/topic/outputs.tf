output "sns_topic_arn" {
  description = "ARN of SNS topic"
  value       = module.sns_topic.this_sns_topic_arn
}
