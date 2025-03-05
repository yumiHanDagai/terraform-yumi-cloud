resource "aws_iam_policy" "example" {
  name        = var.policy_name
  description = "Custom IAM policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListBucket"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}