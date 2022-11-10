#!/usr/bin/env python3
import boto3
from cfnresponse import send, SUCCESS

def get_alias():
    ALIAS = boto3.client('iam').list_account_aliases()['AccountAliases']
    ID = boto3.client('sts').get_caller_identity().get('Account')
    if ALIAS == []:
        return ID
    else:
        return ALIAS[0]

def cloudformation_handler(event, context):
    if event['RequestType'] == 'Create':
        ACC_ALIAS = get_alias()

        response_data = {"success": "true", "acc_alias": ACC_ALIAS}
        send(event, context, SUCCESS, response_data)
    else: 
        response_data = {"success": "true"}
        send(event, context, SUCCESS, response_data)