locals {
  region = "eu-west-2"
  account = "9602-7928-4867"
  common_tags = {
    Environment = "lab"
    Course = "CSA-P"
    LabName = "Air Quality Analysis"
    Eviction = "2019-06-20"
  }
}

provider "aws" {
  region = "${local.region}"
}

terraform {
  backend "s3" {
    bucket = "gisql-terraform-state"
    key = "csa-p/labs/aqa.tfstate"
    region = "eu-west-2"
  }
}

