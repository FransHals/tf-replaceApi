output "function_name" {
    description = "Name of Lambda function."
    value = aws_lambda_function.lookup_replace.function_name
}

output "log_group_arn" {
    description = "The ARN of the Cloudwatch Log group."
    value = aws_cloudwatch_log_group.api.arn
}

output "invoke_arn" {
    description = "The invoke ARN of the Lambda function."
    value = aws_lambda_function.lookup_replace.invoke_arn
}