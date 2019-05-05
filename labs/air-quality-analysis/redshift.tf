resource "random_string" "aqa_user" {
  length = 6
  min_lower = 6
}

resource "random_string" "aqa_password" {
  length = 10
  min_lower = 2
  min_numeric = 1
  min_upper = 1
}

/* Wrong solution: commenting out to avoid cost
resource "aws_redshift_cluster" "aqa" {
  cluster_identifier = "aqa"
  node_type = "dc2.large"
  cluster_type = "single-node"
  master_username = "${random_string.aqa_user.result}"
  master_password = "${random_string.aqa_password.result}"
  tags = "${local.common_tags}"
}
*/

output "Redis Cluster aqa username/password" {
  sensitive = true
  value = "${random_string.aqa_user.result} / ${random_string.aqa_password.result}"
}
