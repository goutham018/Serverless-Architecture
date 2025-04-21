
import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('serverless_workshop_intro')

def lambda_handler(event, context):
    # Perform a scan operation on DynamoDB
    data = table.scan()

    # Return the data in the correct format for Lambda proxy integration
    return {
        "statusCode": 200,  # HTTP status code
        "body": json.dumps(data['Items']),  # Convert the result to a JSON string
        "headers": {
            "Content-Type": "application/json"  # Set the content type to JSON
        }
    }
