provider "aws" {
  region = "eu-west-2"
}

resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "gisql-terraform-state"
  acl = "private"
  versioning {
    enabled = true
  }
  tags = {
    group = "sys"
    use = "terraform"
  }
}

