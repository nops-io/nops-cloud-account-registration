#!/bin/bash

#### setup version
VERSION=$(cat Release_Version)

mkdir packages

## gather cloudformation templates
cp cloudformation-single-acc-register/nops_register_aws_acc.yaml packages/
cp cloudformation-single-acc-register/nops_register_aws_acc.yaml packages/nops_register_aws_acc-${VERSION}.yaml

cp cloudformation-org-member-accounts-register/member_consolidated_aws_acc_nops_register.yaml packages/
cp cloudformation-org-member-accounts-register/member_consolidated_aws_acc_nops_register.yaml packages/member_consolidated_aws_acc_nops_register-${VERSION}.yaml

cp cloudformation-org-member-accounts-register/cloudformation_execution_role.yaml packages/
cp cloudformation-org-member-accounts-register/cloudformation_execution_role.yaml packages/cloudformation_execution_role-${VERSION}.yaml


## gather lambda code zip files
declare -a LAMBDA_PACKAGES
LAMBDA_PACKAGES=(
  generate_external_id 
  nops_register_aws_acc
)

for LAMBDA_PACKAGE in "${LAMBDA_PACKAGES[@]}"
do
  cd lambda_functions/${LAMBDA_PACKAGE}
  pip --version
  pip install -r requirements.txt -t .
  zip -r ${LAMBDA_PACKAGE}.zip .
  cp ${LAMBDA_PACKAGE}.zip ${LAMBDA_PACKAGE}-${VERSION}.zip
  mv ${LAMBDA_PACKAGE}.zip ../../packages
  mv ${LAMBDA_PACKAGE}-${VERSION}.zip ../../packages
  cd -
done

ls -l packages
