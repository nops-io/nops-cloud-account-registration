
resource "aws_s3_bucket" "s3" {
  bucket = "${var.BucketName}-${local.current_acc_id}"
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "s3" {
  bucket = aws_s3_bucket.s3.id
  policy = jsonencode(
    {
      "Version" : "2008-10-17",
      "Statement" : [{
        "Sid" : "Stmt1496253402061",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "billingreports.amazonaws.com"
        },
        "Action" : [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy"
        ],
        "Resource" : "${aws_s3_bucket.s3.arn}",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" : "arn:aws:cur:${local.region}:${local.current_acc_id}:definition/*",
            "aws:SourceAccount" : "${local.current_acc_id}"
          }
        }
        },
        {
          "Sid" : "Stmt1496253402062",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "billingreports.amazonaws.com"
          },
          "Action" : [
            "s3:PutObject"
          ],
          "Resource" : "${aws_s3_bucket.s3.arn}/*",
          "Condition" : {
            "StringEquals" : {
              "aws:SourceArn" : "arn:aws:cur:${local.region}:${local.current_acc_id}:definition/*",
              "aws:SourceAccount" : "${local.current_acc_id}"
            }
          }
        }
      ]
  })
}

resource "aws_cur_report_definition" "cur_report_definition" {
  report_name                = var.ReportName
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.s3.id
  s3_prefix                  = var.s3prefix
  s3_region                  = local.region
  additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
  report_versioning          = "OVERWRITE_REPORT"
  depends_on = [
    aws_s3_bucket.s3
  ]
}

resource "aws_lambda_function" "nops_register_aws_acc" {
  function_name = "nops-register-aws-account"

  role      = aws_iam_role.nops_lambda_role.arn
  handler   = "nops_register_aws_acc.terraform_handler"
  s3_bucket = "nops-register-aws-account-${local.region}"
  s3_key    = "nops_register_aws_acc.zip"

  runtime = "python3.8"
  timeout = 150

  environment {
    variables = {
      api_key                          = var.nOpsApiKey
      external_id                      = var.ExternalId
      report_name                      = var.ReportName
      private_key                      = var.nOpsPrivateKey
      iam_role_for_nops                = aws_iam_role.nops_access_role.arn
      s3_bucket_name_for_nops          = "${var.BucketName}-${local.current_acc_id}"
      aws_acc_name_to_register_in_nops = "${var.AccNameToRegister}-${local.current_acc_id}"
    }
  }
  tags = var.tags
  depends_on = [
    aws_iam_role.nops_access_role,
    aws_iam_role.nops_lambda_role,
    aws_s3_bucket.s3
  ]
}

data "aws_lambda_invocation" "nops_register_aws_acc" {
  function_name = aws_lambda_function.nops_register_aws_acc.function_name

  input = <<JSON
{
  "key1": "value1",
  "key2": "value2"
}
JSON
  depends_on = [
    aws_lambda_function.nops_register_aws_acc
  ]
}