#!/bin/bash
set -e

# -----------------------------
# Configuration
# -----------------------------
AWS_REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
SERVICES=("user-service" "product-service" "order-service")
ECR_REPO_PREFIX="eks-microservice"

# Login to ECR
echo "🔐 Logging in to Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Create repositories if not exist
for SERVICE in "${SERVICES[@]}"; do
  REPO_NAME="${ECR_REPO_PREFIX}-${SERVICE}"
  echo "📦 Checking repository: $REPO_NAME"

  if ! aws ecr describe-repositories --repository-names "$REPO_NAME" --region $AWS_REGION >/dev/null 2>&1; then
    echo "🆕 Creating ECR repository: $REPO_NAME"
    aws ecr create-repository --repository-name "$REPO_NAME" --region $AWS_REGION >/dev/null
  fi
done

# Build and push each microservice
for SERVICE in "${SERVICES[@]}"; do
  REPO_NAME="${ECR_REPO_PREFIX}-${SERVICE}"
  IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:latest"

  echo "🚧 Building Docker image for $SERVICE..."
  docker build -t "$IMAGE_URI" ./services/$SERVICE

  echo "🚀 Pushing image to ECR: $IMAGE_URI"
  docker push "$IMAGE_URI"
done

echo "✅ All images built and pushed successfully!"
