locals {
  region = "eu-west-2"
  account = "9602-7928-4867"
  common_tags = {
    Environment = "production"
    Eviction = "no"
  }
}

provider "aws" {
  region = "${local.region}"
}

terraform {
  backend "s3" {
    bucket = "gisql-terraform-state"
    key = "terraform.tfstate"
    region = "eu-west-2"
  }
}
