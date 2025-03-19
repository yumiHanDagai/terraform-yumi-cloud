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
  key    = "scripts/glue-demo/test_script.py"
  source = "${path.module}/scripts/test_script.py"
  etag   = filemd5("${path.module}/scripts/test_script.py")
}

resource "aws_glue_job" "demo" {
  name         = "no_s3_creation_demo_job"
  role_arn     = "arn:aws:iam::138184589409:role/service-role/AmazonSageMakerServiceCatalogProductsGlueRole"
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
