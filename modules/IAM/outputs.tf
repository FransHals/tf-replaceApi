output "role" {
    description = "IAM role."
    value = aws_iam_role.lambda_execution.arn
}