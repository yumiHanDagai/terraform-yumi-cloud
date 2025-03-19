module "ec2_linux" {
  source = "../../deploy/aws/ec2/linux"
  linux_instance_type = var.linux_instance_type
  linux_instance_name = var.linux_instance_name
}

module "ec2_windows" {
  source = "../../deploy/aws/ec2/windows"
  windows_instance_type = var.windows_instance_type
  windows_instance_name = var.windows_instance_name
}

module "iam_user" {
  source = "../../deploy/aws/iam/user"
  user_name = var.user_name
}

module "iam_custompolicy" {
  source = "../../deploy/aws/iam/custompolicy"
  policy_name = var.policy_name
}

variable "existing_bucket" {
  default = "ndit-skillup-bedrock-video-trans-s3b"
}

# 上传本地脚本到现有 S3 存储桶
resource "aws_s3_object" "glue_script" {
  bucket = var.existing_bucket
  key    = "scripts/glue-demo/script.py"
  source = "${path.module}/scripts/script.py"
  etag   = filemd5("${path.module}/scripts/script.py")
}

# 精简版 Glue 执行角色
resource "aws_iam_role" "glue_role" {
  name = "glue_demo_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "glue.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })

  inline_policy {
    name = "s3_access"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${var.existing_bucket}/*"
      }]
    })
  }
}

resource "aws_glue_job" "demo" {
  name         = "no_s3_creation_demo_job"
  role_arn     = aws_iam_role.glue_role.arn
  glue_version = "4.0"

  command {
    name            = "pythonshell"
    script_location = "s3://${var.existing_bucket}/${aws_s3_object.glue_script.key}"
  }

  default_arguments = {
    "--job-language"        = "python"
    "--job-bookmark-option" = "job-bookmark-disable"
    "--enable-metrics"      = ""
  }

  timeout = 5
}
