resource "aws_iam_role" "AWSServiceRoleForSupport" {
  name = "AWSServiceRoleForSupport"
  path = "/aws-service-role/support.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "support.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForTrustedAdvisor" {
  name = "AWSServiceRoleForTrustedAdvisor"
  path = "/aws-service-role/trustedadvisor.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "trustedadvisor.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
