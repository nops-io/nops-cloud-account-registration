#!/bin/bash

#### setup version
VERSION=$(cat Release_Version)

cd packages

#### create github release
# gh release create --title aws-account-register-${VERSION} ${VERSION} \
#   nops_register_aws_acc.yaml \
#   nops_register_aws_acc-${VERSION}.yaml \
#   member_consolidated_aws_acc_nops_register.yaml \
#   member_consolidated_aws_acc_nops_register-${VERSION}.yaml \
#   cloudformation_execution_role.yaml \
#   cloudformation_execution_role-${VERSION}.yaml \
#   generate_external_id.zip \
#   generate_external_id-${VERSION}.zip \
#   fetch_aws_account_alias.zip \
#   fetch_aws_account_alias-${VERSION}.zip \
#   nops_register_aws_acc.zip \
#   nops_register_aws_acc-${VERSION}.zip
gh release create --title aws-account-register-${VERSION} ${VERSION} *.yaml *.zip
cd -

### upload new files to s3
aws s3 cp packages s3://nops-register-aws-account-us-east-1/ --recursive


