#!/bin/sh
VERSION=$(cat Release_Version)
PACKAGE_NAME="nops_register_aws_acc-${VERSION}.yaml"
if gh release list | grep $PACKAGE_NAME; then
    echo "Duplicated release"
    exit 1
fi
