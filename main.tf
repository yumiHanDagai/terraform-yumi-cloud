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
  ami           = "ami-09a73d1fbb2515f95"   # Amazon Linux AMI
  instance_type = "t2.micro"
  subnet_id     = "subnet-07b73439a9be9b6b4"
  vpc_security_group_ids = ["sg-0486a19418b7c4379"]     
  tags = {
    Name = "test-ec2-create-by-terraform-cloud"
  }
}