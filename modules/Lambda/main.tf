resource "aws_lambda_function" "lookup_replace" {
    function_name = "lookupReplace-api"
    
    s3_bucket = module.S3.bucket
    s3_key = module.S3.key

    runtime = "python3.9"
    handler = "lambda_function.lambda_handler"

    role = module.IAM.role

    tags = {
        Name        = "Deloitte"
        Environment = "Dev"
    }
}

resource "aws_cloudwatch_log_group" "api" {
    name = "/aws/lambda/${aws_lambda_function.lookup_replace.function_name}"

    retention_in_days = 14
    tags = {
        Name        = "Deloitte"
        Environment = "Dev"
    }
}

module "S3" {
    source = "./../S3"
}

module "IAM" {
    source = "./../IAM"
}