data "aws_lambda_function" "lookup_replace" {
    function_name = "lookupReplace-api"
}
resource "aws_api_gateway_rest_api" "lookup_replace_api" {
    name = "lookupReplace"
    binary_media_types = ["UTF-8-encoded"]
    minimum_compression_size = -1
    api_key_source = "HEADER"

    endpoint_configuration {
        types = ["REGIONAL"]
    }
}

resource "aws_api_gateway_resource" "resource" {
    rest_api_id = aws_api_gateway_rest_api.lookup_replace_api.id
    parent_id = aws_api_gateway_rest_api.lookup_replace_api.root_resource_id
    path_part = "sentence"    
}

resource "aws_api_gateway_method" "method" {
    rest_api_id = aws_api_gateway_rest_api.lookup_replace_api.id
    resource_id = aws_api_gateway_resource.resource.id
    http_method = "PUT"
    authorization = "NONE"

}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.lookup_replace_api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "PUT"
  type                    = "AWS_PROXY"
  uri                     = module.Lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
    rest_api_id = aws_api_gateway_rest_api.lookup_replace_api.id

    triggers = {
        redeployment = sha1(
            jsonencode([
                aws_api_gateway_resource.resource.id,
                aws_api_gateway_method.method.id,
                aws_api_gateway_integration.integration.id
             ])
        )
    }

    lifecycle {
        create_before_destroy = true
    }    
}

resource "aws_api_gateway_stage" "stage" {
    stage_name = "test"
    rest_api_id = aws_api_gateway_rest_api.lookup_replace_api.id
    deployment_id = aws_api_gateway_deployment.deployment.id
}

resource "aws_api_gateway_method_response" "http_200_response" {
    rest_api_id = aws_api_gateway_rest_api.lookup_replace_api.id
    resource_id = aws_api_gateway_resource.resource.id
    http_method = aws_api_gateway_method.method.http_method
    status_code = "200"
    response_models = tomap({"Content-Type" = "application/json"})
}

resource "aws_cloudwatch_log_group" "api_gw" {
    name = "/aws/api_gw/${aws_api_gateway_rest_api.lookup_replace_api.id}"

    retention_in_days = 14
}

resource "aws_lambda_permission" "api_gw" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = module.Lambda.function_name
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_api_gateway_rest_api.lookup_replace_api.execution_arn}/*/*/*"
}

module "Lambda" {
    source = "./../Lambda"
}