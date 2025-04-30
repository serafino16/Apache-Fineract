resource "aws_lambda_function" "this" {
  for_each = toset(var.regions)

  function_name = "loan-creation-lambda-${each.value}"

  role    = var.lambda_roles[each.value]
  handler = var.lambda_handler
  runtime = var.lambda_runtime

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      SQS_QUEUE_URL = var.sqs_queues[each.value]
    }
  }

  tags = var.tags
}
resource "aws_iam_role" "this" {
  for_each = toset(var.regions)

  name = "lambda-loan-creation-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}