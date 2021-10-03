resource "aws_iam_role" "lambda_execution" {
    name = "lambda_api"

    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
    tags = {
        Name        = "Deloitte"
        Environment = "Dev"
    }
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
    role       = aws_iam_role.lambda_execution.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}