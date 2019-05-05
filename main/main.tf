resource "aws_s3_bucket" "devmo-io" {
  bucket = "devmo.io"
  acl = "private"
  website {
    index_document = "index.html"
  }
  tags = "${local.common_tags}"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "http better policy",
  "Statement": [
    {
      "Sid": "readonly policy",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::devmo.io/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "hypocrisy-io" {
  bucket = "hypocrisy.io"
  acl = "private"
  website {
    index_document = "index.html"
  }
  tags = "${local.common_tags}"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "http better policy",
  "Statement": [
    {
      "Sid": "readonly policy",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::hypocrisy.io/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_public_access_block" "hypocrisy-io" {
  bucket = "${aws_s3_bucket.hypocrisy-io.bucket}"
  block_public_acls = true
  ignore_public_acls = true
  block_public_policy = false
  restrict_public_buckets = false
}

resource "aws_route53_zone" "devmo-io-public" {
  name = "devmo.io"
  comment = "HostedZone created by Route53 Registrar"
  tags = "${local.common_tags}"
}

resource "aws_route53_zone" "hypocrisy-io-public" {
  name = "hypocrisy.io"
  comment = "HostedZone created by Route53 Registrar"
  tags = "${local.common_tags}"
}

resource "aws_route53_record" "devmo-io-A" {
  zone_id = "${aws_route53_zone.devmo-io-public.zone_id}"
  name = "devmo.io"
  type = "A"

  alias {
    name = "s3-website.${local.region}.amazonaws.com"
    zone_id = "${aws_s3_bucket.devmo-io.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "devmo-io-NS" {
  zone_id = "${aws_route53_zone.devmo-io-public.zone_id}"
  name = "devmo.io"
  type = "NS"
  records = [
    "ns-1064.awsdns-05.org.",
    "ns-785.awsdns-34.net.",
    "ns-456.awsdns-57.com.",
    "ns-1718.awsdns-22.co.uk."
  ]
  ttl = "172800"
}

resource "aws_route53_record" "devmo-io-SOA" {
  zone_id = "${aws_route53_zone.devmo-io-public.zone_id}"
  name = "devmo.io"
  type = "SOA"
  records = [
    "ns-1064.awsdns-05.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl = "900"
}


resource "aws_route53_record" "hypocrisy-io-A" {
  zone_id = "${aws_route53_zone.hypocrisy-io-public.zone_id}"
  name = "hypocrisy.io"
  type = "A"

  alias {
    name = "s3-website.${local.region}.amazonaws.com"
    zone_id = "${aws_s3_bucket.hypocrisy-io.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "hypocrisy-io-NS" {
  zone_id = "${aws_route53_zone.hypocrisy-io-public.zone_id}"
  name = "hypocrisy.io"
  type = "NS"
  records = [
    "ns-245.awsdns-30.com.",
    "ns-2003.awsdns-58.co.uk.",
    "ns-898.awsdns-48.net.",
    "ns-1413.awsdns-48.org."]
  ttl = "172800"
}

resource "aws_route53_record" "hypocrisy-io-SOA" {
  zone_id = "${aws_route53_zone.hypocrisy-io-public.zone_id}"
  name = "hypocrisy.io"
  type = "SOA"
  records = [
    "ns-245.awsdns-30.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl = "900"
}
