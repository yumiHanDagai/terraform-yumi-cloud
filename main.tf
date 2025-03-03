# main.tf
terraform {
  required_version = ">= 1.5.0"
  backend "remote" {  # 使用Terraform Cloud作后端
    hostname     = "app.terraform.io"
    organization = "yumigaizi-org"
    workspaces {
      name = "terraform-yumi-cloud"  # Terraform Cloud中的Workspace名称
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d60652e0357ad94f"   # Amazon Linux AMI
  instance_type = "t2.micro"
  tags = {
    Name = "test-ec2-create-by-terraform-cloud"
  }
}