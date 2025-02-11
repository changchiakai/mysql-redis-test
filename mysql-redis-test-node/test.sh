#!/bin/bash
# 載入環境變數
if [ -f .env ]; then
  source .env
else
  echo ".env 檔案不存在，請先建立 .env 檔案。" 
  exit 1
fi

# 使用環境變數
IMAGE_NAME=${REGION}-docker.pkg.dev/${PROJECT_ID}/${DOCKER_REPO_NAME}/${SERVICE_NAME}:20250210

echo "專案 ID: $PROJECT_ID"
echo "服務名稱: $SERVICE_NAME"
echo "區域: $REGION"
echo "Docker 映像檔: $IMAGE_NAME"
echo "Port: $PORT"
echo "VPC: $NETWORK"
echo "Subnet: $SUBNET"

# gcloud artifacts repositories describe $DOCKER_REPO_NAME --location=$REGION