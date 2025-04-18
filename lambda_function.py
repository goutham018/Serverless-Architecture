import json
import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['DYNAMODB_TABLE_NAME']
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    http_method = event['httpMethod']
    
    if http_method == 'POST':
        return add_user(event)
    elif http_method == 'GET':
        return get_user(event)
    else:
        return {
            'statusCode': 405,
            'body': json.dumps({'message': 'Method Not Allowed'})
        }

def add_user(event):
    user_data = json.loads(event['body'])
    user_id = user_data['user_id']
    name = user_data['name']
    
    table.put_item(
        Item={
            'user_id': user_id,
            'name': name
        }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'User added successfully'})
    }

def get_user(event):
    user_id = event['queryStringParameters']['user_id']
    
    response = table.query(
        KeyConditionExpression=Key('user_id').eq(user_id)
    )
    
    if 'Items' in response and len(response['Items']) > 0:
        return {
            'statusCode': 200,
            'body': json.dumps(response['Items'][0])
        }
    else:
        return {
            'statusCode': 404,
            'body': json.dumps({'message': 'User not found'})
        }
