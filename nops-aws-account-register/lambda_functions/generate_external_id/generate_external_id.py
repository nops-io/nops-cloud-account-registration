#!/usr/bin/env python3
import uuid
from cfnresponse import send, SUCCESS

def generate_random_string(length: int = 10, uppercase: bool = True) -> str:
    random_string = str(uuid.uuid4())[:length]
    random_string = random_string.replace("-", "a")

    if uppercase:
        return random_string.upper()

    return random_string


def cloudformation_handler(event, context):
    if event['RequestType'] == 'Create':
        external_id = generate_random_string(length=30, uppercase=True)

        response_data = {"success": "true", "external_id": external_id}
        send(event, context, SUCCESS, response_data)
    else: 
        response_data = {"success": "true"}
        send(event, context, SUCCESS, response_data)