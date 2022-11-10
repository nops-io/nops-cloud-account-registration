#!/bin/bash

#### setup version
VERSION=$(cat Release_Version)

cd packages

#### create github release
gh release create --title aws-account-register-${VERSION} ${VERSION} *.yaml *.zip
cd -

### upload new files to s3
aws s3 cp packages s3://nops-register-aws-account-us-east-1/ --recursive


