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
