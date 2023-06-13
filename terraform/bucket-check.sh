#!/bin/bash

bucketstatus=$(aws s3api head-bucket --bucket "$1" 2>&1)

if [ $? != 0 ]; then   
    if echo "${bucketstatus}" | grep 'Not Found'; then 
        echo "Bucket does not exist, creating..."
        aws s3 mb s3://$1
    else 
        echo "Error checking bucket"
        echo "$bucketstatus"
        exit 1
    fi
else
    echo "Bucket exists"
fi