resource "aws_iam_user" "example" {
  name = var.user_name
  path = "/system/"

  tags = {
    Description = "Managed by Terraform Cloud"
  }
}