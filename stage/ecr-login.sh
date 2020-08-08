#!/bin/bash
REGION="us-east-1"
ECR_URI="873301793325.dkr.ecr.us-east-1.amazonaws.com/myproject-service"

`aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_URI}`
