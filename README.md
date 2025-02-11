# Cloud Run + MySQL & Redis Test Project

## 介紹

這個專案是為了測試 Cloud Run 是否能夠連線到 GCP VM 上的 MySQL 和 Redis。
專案使用 `Express.js` 作為 Web 框架，並整合了 `Sequelize` 來操作 MySQL，以及 `ioredis` 來與 Redis 互動。

## 需求

- Node.js 18+
- Docker
- GCP 設定 (Cloud Run, VM, MySQL, Redis)

## 安裝與執行

### 1. Clone 專案

```sh
 git clone https://github.com/your-repo/cloud-run-mysql-redis.git
```

### 2. 安裝依賴

```sh
cd mysql-redis-test-node
npm install
```

### 3. 設定環境變數

於 `mysql-redis-test-node` 目錄
請在專案根目錄複製 `.env.template` 變成 `.env` 檔案，並填入以下內容 (請根據你的環境修改)：

```
PROJECT_ID=example-project
SERVICE_NAME=example-service
REGION=us-central1
DOCKER_REPO_NAME=example-repo
PORT=8789
NETWORK=example-vpc
SUBNET=example-subnet
MYSQL_HOST=192.168.1.1
MYSQL_USER=root
MYSQL_PASSWORD=password
MYSQL_DATABASE=test_db
REDIS_HOST=192.168.1.2
REDIS_PORT=6379
REDIS_PASSWORD=e4d1f8c9-9b35-4a7b-a6d7-3f820c5e2f12
```

### 4. 啟動服務

```
node .
```


## API 說明

### 1. 測試 API

**根路由**

```sh
GET /
```

回應：`Hello from Cloud Run with Redis!`

### 2. 取得所有使用者 (MySQL)

```sh
GET /users
```

回應：

```json
[
  { "id": 1, "name": "John Doe", "email": "john@example.com" }
]
```

### 3. 設定 Redis 鍵值

```sh
GET /set?key=myKey&value=myValue
```

回應：`Key "myKey" set with value "myValue"`

### 4. 取得 Redis 鍵值

```sh
GET /get?key=myKey
```

回應：`Value for key "myKey": myValue`

## 部署到 Cloud Run

### 1. 部署到 Cloud Run

```sh
bash ./deploy.sh
```

## 結論

此專案驗證了 Cloud Run 是否能夠成功連接到 GCP VM 上的 MySQL 和 Redis。測試成功的話，應該可以透過 API 存取 MySQL 資料表與 Redis 資料。

