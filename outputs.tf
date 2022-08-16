output "arn" {
  description = "The ARN of the configured role"
  value       = aws_iam_role.this.arn
}
