#!/bin/bash

#### setup version
VERSION=$(cat Release_Version)

mkdir packges

## gather cloudformation templates
cp cloudformation-single-acc-register/nops_register_aws_acc.yaml packges/
cp cloudformation-single-acc-register/nops_register_aws_acc.yaml packges/nops_register_aws_acc-${VERSION}.yaml

cp cloudformation-org-member-accounts-register/member_consolidated_aws_acc_nops_register.yaml packges/
cp cloudformation-org-member-accounts-register/member_consolidated_aws_acc_nops_register.yaml packges/member_consolidated_aws_acc_nops_register-${VERSION}.yaml

cp cloudformation-org-member-accounts-register/cloudformation_execution_role.yaml packges/
cp cloudformation-org-member-accounts-register/cloudformation_execution_role.yaml packges/cloudformation_execution_role-${VERSION}.yaml


## gather lambda code zip files
declare -a LAMBDA_PACKAGES
LAMBDA_PACKAGES=(
  generate_external_id 
  nops_register_aws_acc
)

for LAMBDA_PACKAGE in "${LAMBDA_PACKAGES[@]}"
do
  cd lambda_functions/${LAMBDA_PACKAGE}
  pip install -r requirements.txt -t .
  zip -r ${LAMBDA_PACKAGE}.zip .
  cp ${LAMBDA_PACKAGE}.zip ${LAMBDA_PACKAGE}-${VERSION}.zip
  mv ${LAMBDA_PACKAGE}.zip ../../packges
  mv ${LAMBDA_PACKAGE}-${VERSION}.zip ../../packges
  cd -
done

