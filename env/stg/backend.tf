terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "yumigaizi-org"

    workspaces {
      name = "terraform-yumi-cloud-stg"
    }
  }
}
