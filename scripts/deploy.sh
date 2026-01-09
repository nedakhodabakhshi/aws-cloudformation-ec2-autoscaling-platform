#!/bin/bash
set -e

STACK_NAME=cfn-ec2-asg-platform
REGION=us-east-1

echo "Deploying CloudFormation stack..."

aws cloudformation deploy \
  --template-file packaged.yaml \
  --stack-name $STACK_NAME \
  --region $REGION \
  --parameter-overrides file://params/dev.json \
  --capabilities CAPABILITY_NAMED_IAM

echo "Deployment completed successfully."
