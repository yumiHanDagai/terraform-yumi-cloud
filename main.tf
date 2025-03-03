# main.tf
terraform {
  required_version = ">= 1.5.0"
  backend "remote" {  # �g�pTerraform Cloud��?�@�[
    hostname     = "app.terraform.io"
    organization = "<YOUR_TF_CLOUD_ORG_NAME>"
    workspaces {
      name = "ec2-test-dev"  # ??Terraform Cloud���IWorkspace����
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  tags = {
    Name = "TestInstance"
  }
}