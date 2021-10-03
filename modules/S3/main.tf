
# The S3 Bucket to store the lookupReplace code for Lambda.
resource "aws_s3_bucket" "lambda_code" {
    bucket          = "code-lambda-lookup-replace"
    acl             = "private"
    force_destroy   = true

    tags = {
        Name        = "Deloitte"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_object" "lookup_replace_py" {
    bucket          = aws_s3_bucket.lambda_code.bucket
    key             = "lookupReplace.py.zip"
    source          = "${path.module}/lookup-replace.py.zip"

    tags = {
        Name        = "Deloitte"
        Environment = "Dev"
    }
}