resource "aws_s3_bucket" "csa-p-athena-test" {
  bucket = "csa-p-athena-test"
  tags = "${local.common_tags}"
  force_destroy = true
}

resource "aws_athena_database" "csa-p-athena-test" {
  bucket = "${aws_s3_bucket.csa-p-athena-test.bucket}"
  name = "aqa"
  force_destroy = true
}

resource "aws_athena_named_query" "create-local-aqa" {
  database = "${aws_athena_database.csa-p-athena-test.name}"
  name = "create-local-aqa"
  query = <<SQL
CREATE EXTERNAL TABLE IF NOT EXISTS aqa.local_aqa (
  `date` struct<`utc`:string,`local`:string>,
  `averagingPeriod` struct<`value`:double,`unit`:string>,
  `parameter` string,
  `value` double,
  `unit` string,
  `city` string,
  `country` string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://csa-p-athena-test/realtime/';
SQL
}

resource "aws_athena_named_query" "create-external-aqa" {
  database = "${aws_athena_database.csa-p-athena-test.name}"
  name = "create-external-aqa"
  query = <<SQL
CREATE EXTERNAL TABLE IF NOT EXISTS aqa.external_aqa (
  `date` struct<`utc`:string,`local`:string>,
  `averagingPeriod` struct<`value`:double,`unit`:string>,
  `parameter` string,
  `value` double,
  `unit` string,
  `city` string,
  `country` string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://openaq-fetches/realtime-gzipped/';
SQL
}

resource "aws_athena_named_query" "create-external-small-aqa" {
  database = "${aws_athena_database.csa-p-athena-test.name}"
  name = "create-external-small-aqa"
  query = <<SQL
CREATE EXTERNAL TABLE IF NOT EXISTS aqa.external_small_aqa (
  `date` struct<`utc`:string,`local`:string>,
  `averagingPeriod` struct<`value`:double,`unit`:string>,
  `parameter` string,
  `value` double,
  `unit` string,
  `city` string,
  `country` string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://openaq-fetches/realtime-gzipped/2018-10-09';
SQL
}

resource "aws_athena_named_query" "cpa-p-aqa-solution" {
  database = "${aws_athena_database.csa-p-athena-test.name}"
  name = "cpa-p-aqa-solution"
  query = <<SQL
SELECT avg(value), city
FROM "aqa"."external_small_aqa"
WHERE country = 'US' AND parameter = 'o3'
GROUP BY city
ORDER BY 1 DESC limit 1
SQL
}
