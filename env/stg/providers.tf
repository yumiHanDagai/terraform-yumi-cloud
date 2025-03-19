terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  assume_role_with_web_identity {
    role_arn          = "arn:aws:iam::138184589409:role/tfc-test-role-20250317"
    session_name      = "terraform-session"
  }
}
