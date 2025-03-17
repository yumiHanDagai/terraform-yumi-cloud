terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "yumigaizi-org"

    workspaces {
      name = "stg-terrafrom-cloud-for-test"
    }
  }
}
