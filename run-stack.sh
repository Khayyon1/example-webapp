#!/bin/bash
set -e
set -x

ACTION = $1
STACK_NAME=$2
ALB_LISTENER_ARN=$3

aws cloudformation $ACTION \
    --region us-east-1 \
    --stack-name $STACK_NAME \
    --template-body file://service.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters \
    ParameterKey=DockerImage,ParameterValue=991044440433.dkr.ecr.us-east-1.amazonaws.com/example-webapp:$(git rev-parse HEAD) \
    ParameterKey=VPC,ParameterValue=vpc-0ba1e5746f1351aee
    ParameterKey=Cluster,ParameterValue=jenkins-cluster \
    ParameterKey=Listener,ParameterValue=$ALB_LISTENER_ARN