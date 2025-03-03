# main.tf
terraform {
  required_version = ">= 1.5.0"
  backend "remote" {  # �g�pTerraform Cloud��@�[
    hostname     = "app.terraform.io"
    organization = "yumigaizi-org"
    workspaces {
      name = "terraform-yumi-cloud"  # Terraform Cloud���IWorkspace����
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d60652e0357ad94f"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  tags = {
    Name = "test_ec2_create_by_terraform_cloud"
  }
}