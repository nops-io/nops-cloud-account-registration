resource "aws_iam_role" "nops_access_role" {
  name = "nops_access_role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : "arn:aws:iam::${local.nops_acc_id}:root"
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : "${var.ExternalId}"
            }
          }
        }
      ]
  })

  inline_policy {
    name = "inline"
    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Action" : [
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
            ],
            "Resource" : "*"
            "Effect" : "Allow"
          },
          {
            "Action" : [
              "s3:*"
            ],
            "Effect" : "Allow",
            "Resource" : [
              "arn:aws:s3:::${aws_s3_bucket.s3.arn}",
              "arn:aws:s3:::${aws_s3_bucket.s3.arn}/*"
            ]
          }
        ]
      }
    )
  }
}

resource "aws_iam_role" "nops_lambda_role" {
  name = "nops_lambda_execution_Role"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })

  inline_policy {
    name = "inline"
    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Action" : [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource" : "*",
            "Effect" : "Allow"
          }
        ]
    })
  }
}