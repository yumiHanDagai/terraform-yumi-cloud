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
