#!/bin/bash
set -e

AWS_REGION="us-west-2"
IMAGE_NAME="hello-java"
IMAGE_TAG="v1"

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME"

aws ecr get-login-password --region $AWS_REGION \
| docker login --username AWS --password-stdin $ECR_REPO

docker build -t $IMAGE_NAME:$IMAGE_TAG app/
docker tag $IMAGE_NAME:$IMAGE_TAG $ECR_REPO:$IMAGE_TAG
docker push $ECR_REPO:$IMAGE_TAG