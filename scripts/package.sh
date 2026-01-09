#!/bin/bash
set -e

STACK_NAME=cfn-ec2-asg-platform
REGION=us-east-1
S3_BUCKET=cfn-artifacts-$RANDOM

echo "Creating S3 bucket for CloudFormation artifacts..."
aws s3 mb s3://$S3_BUCKET --region $REGION

echo "Packaging CloudFormation templates..."
aws cloudformation package \
  --template-file templates/main.yaml \
  --s3-bucket $S3_BUCKET \
  --output-template-file packaged.yaml

echo "Package completed: packaged.yaml created."
