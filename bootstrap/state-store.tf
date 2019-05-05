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

resource "aws_s3_bucket_public_access_block" "terraform-state-bucket" {
  bucket = "${aws_s3_bucket.terraform-state-bucket.bucket}"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
