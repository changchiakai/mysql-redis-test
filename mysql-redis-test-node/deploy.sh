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
echo $IMAGE_NAME
echo "專案 ID: $PROJECT_ID"
echo "服務名稱: $SERVICE_NAME"
echo "區域: $REGION"
echo "Docker 映像檔: $IMAGE_NAME"
echo "Port: $PORT"
echo "VPC: $NETWORK"
echo "Subnet: $SUBNET"

# gcloud artifacts repositories describe  momo-outbound-online-uat --location=asia-east1
# 建立 Docker 映像檔
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# 推送映像檔到 Google Container Registry
echo "Pushing Docker image to GCR..."
docker push $IMAGE_NAME

# 部署到 Cloud Run
echo "Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE_NAME \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --vpc-egress=all-traffic \
  --network=${NETWORK} \
        --subnet=${SUBNET} \
  --allow-unauthenticated \
        --port=${PORT}
# 完成
echo "Deployment complete!"