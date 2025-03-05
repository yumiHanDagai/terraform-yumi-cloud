variable "user_name" {}
variable "policy_name" {}
variable "linux_instance_type" {}
variable "linux_instance_name" {}
variable "windows_instance_type" {}
variable "windows_instance_name" {}

module "ec2_linux" {
  source = "./ec2/linux"
}

module "ec2_windows" {
  source = "./ec2/windows"
}

module "iam_user" {
  source = "./iam/user"
}

module "iam_custompolicy" {
  source = "./iam/custompolicy"
}
