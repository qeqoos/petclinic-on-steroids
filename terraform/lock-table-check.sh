#!/bin/bash

dynamodbstatus=$(aws dynamodb describe-table --table-name "$1" 2>&1)

if [ $? != 0 ]; then   
    if echo "${dynamodbstatus}" | grep 'not found'; then 
        echo "DynamoDB lock table does not exist, creating..."
        aws dynamodb create-table --table-name $1 --cli-input-json file://dynamodb_table.json
    else 
        echo "Error checking DynamoDB"
        echo "$dynamodbstatus"
        exit 1
    fi
else
    echo "Lock table exists"
fi