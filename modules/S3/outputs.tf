output "bucket" {
    description = "Name of the S3 bucket."
    value = aws_s3_bucket.lambda_code.bucket
}

output "key" {
    description = "Name of the lambda code file in S3 bucket."
    value = aws_s3_bucket_object.lookup_replace_py.key
}