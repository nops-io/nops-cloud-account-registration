data "aws_region" "current" {}
data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "Trusted_Policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.ExternalId]
    }

    principals {
      type        = "AWS"
      identifiers = [local.nops_acc_id] # Enter Trusted Account Number Here
    }
  }
}


data "aws_iam_policy_document" "Policy_For_Bucket" {
  statement {
    sid    = ""
    effect = "Allow"
    resources = [
      aws_s3_bucket.s3.arn,
      "${aws_s3_bucket.s3.arn}/*"
    ]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "ce:GetCostAndUsage",
      "ce:GetReservationPurchaseRecommendation",
      "ce:GetRightsizingRecommendation",
      "ce:GetSavingsPlansPurchaseRecommendation",
      "cloudformation:DescribeStackResources",
      "cloudformation:DescribeStacks",
      "cloudformation:GetTemplate",
      "cloudfront:ListDistributions",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetTrailStatus",
      "cloudtrail:LookupEvents",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "config:DescribeConfigurationRecorderStatus",
      "config:DescribeConfigurationRecorders",
      "config:DescribeDeliveryChannelStatus",
      "config:DescribeDeliveryChannels",
      "cur:DescribeReportDefinitions",
      "cur:PutReportDefinition",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "ec2:DescribeAddresses",
      "ec2:DescribeClientVpnConnections",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcs",
      "ecs:DescribeClusters",
      "ecs:ListClusters",
      "eks:ListClusters",
      "elasticache:DescribeCacheClusters",
      "elasticache:DescribeCacheSubnetGroups",
      "elasticache:DescribeReplicationGroups",
      "elasticfilesystem:DescribeFileSystems",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elb:DescribeLoadBalancers",
      "es:DescribeElasticsearchDomains",
      "guardduty:ListDetectors",
      "iam:GetAccessKeyLastUsed",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:GetLoginProfile",
      "iam:GetRole",
      "iam:ListAccessKeys",
      "iam:ListAccountAliases",
      "iam:ListAttachedGroupPolicies",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupsForUser",
      "iam:ListMFADevices",
      "iam:ListRoles",
      "iam:ListUserPolicies",
      "iam:ListUsers",
      "inspector:ListAssessmentRuns",
      "kms:ListKeys",
      "lambda:GetFunction",
      "lambda:GetPolicy",
      "lambda:ListFunctions",
      "rds:DescribeDBInstances",
      "rds:DescribeDBSnapshots",
      "rds:DescribePendingMaintenanceActions",
      "rds:ListTagsForResource",
      "redshift:DescribeClusters",
      "s3:GetBucketAcl",
      "s3:GetBucketLogging",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketVersioning",
      "s3:GetEncryptionConfiguration",
      "s3:ListAllMyBuckets",
      "ssm:ListComplianceSummaries",
      "support:DescribeCases",
      "support:DescribeTrustedAdvisorCheckRefreshStatuses",
      "support:DescribeTrustedAdvisorCheckResult",
      "support:DescribeTrustedAdvisorChecks",
      "tag:getResources",
      "tag:getTagKeys",
      "tag:getTagValues",
      "wellarchitected:*",
      "workspaces:DescribeWorkspaceDirectories",
      "workspaces:DescribeWorkspaces"
    ]
  }
}