#!/bin/bash
set -e

echo "Validating main CloudFormation template..."

aws cloudformation validate-template \
  --template-body file://templates/main.yaml

echo "Validation successful."
