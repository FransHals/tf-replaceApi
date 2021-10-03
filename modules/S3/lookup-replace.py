import json

def lambda_handler(event, context):

    # 1. Initialize String
    inputString = event['queryStringParameters']["inputString"]
    # © is '\u00a9'

    # 2. Define Lookup Dictionary
    # •	Oracle -> Oracle©
    # •	Google -> Google©
    # •	Microsoft -> Microsoft©
    # •	Amazon -> Amazon©
    # •	Deloitte -> Deloitte©
    lookp_dict = {"Oracle" : "Oracle" + '\u00a9', "Google" : "Google" + '\u00a9',
                  "Microsoft" : "Microsoft"  + '\u00a9', "Amazon" : "Amazon" + '\u00a9',
                  "Deloitte" : "Deloitte" + '\u00a9'}

    # 3. Response is the outputString
    outputString = " ".join(lookp_dict.get(ele, ele) for ele in inputString.split())
    print(outputString)

    # # 4. Construct http response object
    # responseObject = {}
    # responseObject['statusCode'] = 200
    # responseObject['headers']{}
    # responseObject['headers']['Content-Type'] = 'application/json'
    # responseObject['body'] =
    return {
        'statusCode': 200,
        'body': json.dumps(outputString)
    }
