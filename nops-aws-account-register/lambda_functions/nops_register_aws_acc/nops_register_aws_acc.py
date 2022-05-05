#!/usr/bin/env python3
from os import environ
import requests
import binascii 
import datetime
from Cryptodome.Hash import SHA256 
from Cryptodome.PublicKey import RSA 
from Cryptodome.Signature import pkcs1_15
from cfnresponse import send, SUCCESS

def main_function():
    #### vars setup
    is_member_acc = environ.get('is_member_acc', "False")
    api_key = environ.get('api_key')
    iam_role_for_nops = environ.get('iam_role_for_nops')
    external_id = environ.get('external_id')
    aws_acc_name_to_register_in_nops = environ.get('aws_acc_name_to_register_in_nops')
    client_id = api_key.split(".")[0]
    url = f"https://app.nops.io/c/admin/projectaws/?api_key={api_key}"

    if is_member_acc == "True":
        data = {
            "access_type": "role",
            "arn": iam_role_for_nops,
            "external_id": external_id,
            "name": aws_acc_name_to_register_in_nops,
            "client": client_id,
            "cloud_type":"aws"
        }
    else:
        s3_bucket_name_for_nops = environ.get('s3_bucket_name_for_nops')
        report_name = environ.get('report_name')
        data = {
            "access_type": "role",
            "arn": iam_role_for_nops,
            "bucket": s3_bucket_name_for_nops,
            "external_id": external_id,
            "name": aws_acc_name_to_register_in_nops,
            "client": client_id,
            "cloud_type":"aws",
            "report_name": report_name
        }

    if(len(environ.get('private_key')) == 0):
        print("private key not found in variable proceeding without signature")
        response = requests.post(url, json=data)
        print(response)
        print(response.text)
    else:
        print("private key found in variable")
        private_key = environ.get('private_key')
        private_key = private_key.split('\\n')
        private_key = '\n'.join(private_key)
        date = datetime.datetime.now().strftime("%Y-%m-%d")
        endpoint = f"/c/admin/projectaws/?api_key={api_key}"
        string_to_sign = f"{client_id}.{date}.{endpoint}"
        encryption_key = RSA.import_key(private_key)
        encoded_string = string_to_sign.encode()
        byte_array = bytearray(encoded_string)
        sha_bytes = SHA256.new(byte_array)
        signature = pkcs1_15.new(encryption_key).sign(sha_bytes)
        signature = binascii.b2a_base64(signature)[:-1].decode()
        headers = {"x-nops-signature": signature}
        response = requests.post(url, headers=headers, json=data)
        print(response)
        print(response.text)

def cloudformation_handler(event, context):
    if event['RequestType'] == 'Create':
        main_function()

    response_data = {"success": "true"}
    send(event, context, SUCCESS, response_data)

def terraform_handler(event, context):
    main_function()

